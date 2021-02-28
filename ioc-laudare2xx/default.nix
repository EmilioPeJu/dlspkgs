{ epicsRepoBaseUrl, stdenv, dls-epics-base, edm, patch-configure, iocbuilder
, dls-epics-asyn, dls-epics-streamdevice, dls-epics-busy, dls-epics-laudare2xx
, config }:

stdenv.mkDerivation rec {
  name = "ioc-laudare2xx";
  phases = [ "buildPhase" "installPhase" "fixupPhase" ];

  iocXml = builtins.toFile "iocXml" ''
    <?xml version="1.0" ?>
    <components arch="linux-x86_64">
      <asyn.AsynIP name="laudaPort1" port="${config.ipAddr}"/>
      <laudaRE2xx.lRE2xx ADDR="0" HIGH="180" HIHI="200" LOLO="-20" LOW="-15" P="${config.pvPrefix}" PORT="laudaPort1" SCAN="5" name="LAUDA"/>
      <asyn.auto_asynRecord ADDR="0" IMAX="1024" OMAX="1024" P="${name}" PORT="laudaPort1" R=":ASYN1" name="${name}.Asyn1"/>
    </components>
  '';

  iocRelease = builtins.toFile "iocRelease" ''
    ASYN=
    STREAMDEVICE=
    BUSY=
    LAUDARE2XX=
  '';

  buildInputs = [
    dls-epics-base
    edm
    iocbuilder
    patch-configure
    dls-epics-asyn
    dls-epics-streamdevice
    dls-epics-busy
    dls-epics-laudare2xx
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
