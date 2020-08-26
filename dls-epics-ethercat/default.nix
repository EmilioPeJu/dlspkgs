{ buildEpicsModule, libxml2, etherlab, dls-epics-asyn, dls-epics-busy, python2
, python2Packages }:

buildEpicsModule {
  name = "dls-epics-ethercat";
  src =
    builtins.fetchGit { url = "https://github.com/dls-controls/ethercat.git"; };
  preConfigure = ''
    cat <<EOF >> configure/CONFIG_SITE
    ETHERLAB = ${etherlab.dev}
    LIBXML2 = ${libxml2.dev}
    EOF
  '';
  patches = [ ./config-for-external-libs.patch ./fix-shebangs.patch ];
  buildInputs = [
    etherlab
    dls-epics-asyn
    dls-epics-busy
    libxml2.dev
    python2
    python2Packages.libxml2
  ];
  NIX_CFLAGS_COMPILE = "-Wno-error=format-security";
}
