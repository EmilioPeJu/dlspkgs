{ epicsRepoBaseUrl, libxml2, buildEpicsModule, dls-epics-asyn, dls-epics-adcore
, dls-epics-ffmpegserver, dls-epics-adsimdetector, boost }:

buildEpicsModule {
  name = "dls-epics-adUtil";
  buildInputs = [
    libxml2
    dls-epics-asyn
    dls-epics-adcore
    dls-epics-ffmpegserver
    dls-epics-adsimdetector
    boost
  ];
  postConfigure = ''
    # remove CONFIG_SITE to use system boost
    rm configure/CONFIG_SITE.linux-x86_64.Common
  '';
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/adutil";
    ref = "master";
  };
}
