{ epicsRepoBaseUrl, buildEpicsModule, doxygen, libtirpc, rpcsvc-proto }:

buildEpicsModule {
  name = "dls-epics-asyn";
  buildInputs = [ doxygen libtirpc libtirpc.dev rpcsvc-proto ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/asyn";
    ref = "dls-master";
  };
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
