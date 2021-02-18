{ epicsRepoBaseUrl, stdenv, dls-epics-base, edm, patch-configure, iocbuilder
, dls-epics-adsimdetector, dls-epics-motor, dls-epics-adutil, dls-epics-adpython
, dls-epics-simhdf5detector, dls-epics-deviocstats }:

stdenv.mkDerivation rec {
  name = "TS-EA-IOC-01";
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/${name}"; };
  patches = [ ./no-ugly-buttons.patch ];
  buildInputs = [
    dls-epics-base
    edm
    iocbuilder
    patch-configure
    dls-epics-adsimdetector
    dls-epics-motor
    dls-epics-adutil
    dls-epics-adpython
    dls-epics-simhdf5detector
    dls-epics-deviocstats
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
    ./st@name@.sh 6064
  '';
  buildPhase = ''
    patch-configure ${name}_RELEASE
    dls-xml-iocbuilder.py -e -o ./ ./${name}.xml
    if [ -f "prepareCustom.sh" ]; then
      ./prepareCustom.sh ${name} ${name}
    fi
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
