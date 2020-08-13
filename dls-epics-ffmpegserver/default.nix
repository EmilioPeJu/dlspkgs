{ epicsRepoBaseUrl, readline, libxml2, ffmpeg-full, buildEpicsModule
, dls-epics-asyn, dls-epics-adcore, dls-epics-adsimdetector }:

buildEpicsModule {
  name = "dls-epics-ffmpegserver";
  buildInputs = [
    readline
    libxml2.dev
    ffmpeg-full
    dls-epics-asyn
    dls-epics-adcore
    dls-epics-adsimdetector
  ];
  patches = [ ./use-sys-libs.patch ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/ffmpegServer";
    ref = "dls-master";
  };
}
