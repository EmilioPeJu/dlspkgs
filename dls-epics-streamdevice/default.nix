{ epicsRepoBaseUrl, fetchgit, readline, buildEpicsModule, dls-epics-asyn }:

buildEpicsModule {
  name = "dls-epics-streamdevice";
  buildInputs = [ readline dls-epics-asyn ];
  NIX_CFLAGS_COMPILE = "-Wno-error=format-security";
  extraEtc = ./etc;
  src = fetchgit {
    url = "https://github.com/paulscherrerinstitute/StreamDevice";
    rev = "2.8.19";
    sha256 = "1pfyxb6l9aqmy4kpsm3iz2j23rpjiwgqmk65jb5k3c89d193ml2i";
  };
}
