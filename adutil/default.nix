{ epicsRepoBaseUrl, libxml2, buildEpicsModule, asyn, adcore
, ffmpegserver, adsimdetector, boost }:

buildEpicsModule {
  name = "adUtil";
  buildInputs = [
    libxml2
    asyn
    adcore
    ffmpegserver
    adsimdetector
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
  patches = [ ./builder-to-py3.patch ];
}
