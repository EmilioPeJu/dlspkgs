{ buildEpicsModule, libxml2, etherlab, asyn, busy, python2
, python2Packages }:

buildEpicsModule {
  name = "ethercat";
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
    asyn
    busy
    libxml2.dev
    python2
    python2Packages.libxml2
  ];
  NIX_CFLAGS_COMPILE = "-Wno-error=format-security";
}
