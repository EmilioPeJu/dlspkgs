{ epicsRepoBaseUrl, fetchgit, buildEpicsModule, doxygen, libtirpc, rpcsvc-proto
}:

buildEpicsModule {
  name = "asyn";
  buildInputs = [ doxygen libtirpc libtirpc.dev rpcsvc-proto ];
  extraEtc = ./etc;
  src = fetchgit {
    url = "https://github.com/epics-modules/asyn";
    rev = "R4-42";
    sha256 = "0sv7lj6188nsrpzdzky4qv2kgszs9m9karbw9f36aq1lla0kijs3";
    fetchSubmodules = false;
  };
  patches = [ ./fix-script-host-path.patch ];
  postConfigure = ''
    cat >> configure/CONFIG_SITE <<EOF
    TIRPC=YES
    USR_INCLUDES_Linux += -I${libtirpc.dev}/include/tirpc
    EOF
  '';
  preInstall = ''
    mkdir -p $out/data
    cp opi/edm/*.edl $out/data
  '';
}
