{ epicsRepoBaseUrl, fetchgit, readline, libxml2, ffmpeg-full, buildEpicsModule
, asyn, adcore }:

buildEpicsModule {
  name = "ffmpegserver";
  buildInputs =
    [ readline libxml2.dev ffmpeg-full asyn adcore ];
  propagatedBuildInputs = [ ffmpeg-full ];
  extraEtc = ./etc;
  NIX_CFLAGS_COMPILE = "-fcommon";
  src = fetchgit {
    url = "https://github.com/areaDetector/ffmpegServer";
    rev = "9fe0d46b49572c229b20d5cd6054fd6fb3cb419f";
    sha256 = "0c990snl2qnvnj975ll9ihy5kcn3b3zi1k89nrclgqcq07jsc6v4";
  };
  patches = [ ./use-sys-libs.patch ./fix-wrong-dirname.patch ];
}
