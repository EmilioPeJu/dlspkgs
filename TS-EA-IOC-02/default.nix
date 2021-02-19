{ epicsRepoBaseUrl, stdenv, dls-epics-base, edm, patch-configure, iocbuilder
, dls-epics-asyn, dls-epics-streamdevice, dls-epics-harvardsyringe, config }:

stdenv.mkDerivation rec {
  name = "TS-EA-IOC-02";
  phases = [ "buildPhase" "installPhase" "fixupPhase" ];

  iocXml = builtins.toFile "iocXml" ''
    <?xml version="1.0" ?>
    <components arch="linux-x86_64">
      <asyn.AsynIP name="syringePort1" port="${config.ipAddr}"/>
      <harvardSyringe.harvardSyringe P="${config.pvPrefix}" PORT="syringePort1" Q="" name="SPUMP"/>
    </components>
  '';

  iocRelease = builtins.toFile "iocRelease" ''
    ASYN=
    STREAMDEVICE=
    HARVARDSYRINGE=
  '';

  buildInputs = [
    dls-epics-base
    edm
    iocbuilder
    patch-configure
    dls-epics-asyn
    dls-epics-streamdevice
    dls-epics-harvardsyringe
  ];
  runtimeShell = stdenv.shell;
  stGui = builtins.toFile "st-gui" ''
    #!@runtimeShell@
    cd @out@/bin/linux-x86_64
    ./st@name@-gui "$@"
  '';
  stIoc = builtins.toFile "st-ioc" ''
    #!@runtimeShell@
    cd @out@/bin/linux-x86_64
    ./st@name@.sh "$@"
  '';
  buildPhase = ''
    mkdir source
    cd source
    cp ${iocXml} ${name}.xml
    chmod +rw ${name}.xml
    cp ${iocRelease} ${name}_RELEASE
    chmod +rw ${name}_RELEASE
    patch-configure ${name}_RELEASE
    dls-xml-iocbuilder.py -e -o ./ ./${name}.xml
    substituteInPlace \
        ./${name}/${name}App/opi/edl/st${name}-gui --replace 'edm' \
        '${edm}/bin/edm'
  '';
  installPhase = ''
    cp -rf ${name} $out
    make -C $out
    substituteAll $stGui $out/bin/${name}-gui
    chmod +x $out/bin/${name}-gui
    substituteAll $stIoc $out/bin/${name}.sh
    chmod +x $out/bin/${name}.sh
  '';
}
