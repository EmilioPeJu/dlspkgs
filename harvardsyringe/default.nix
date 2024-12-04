{ epicsRepoBaseUrl, buildEpicsModule, asyn, streamdevice }:

buildEpicsModule {
  name = "harvardsyringe";
  buildInputs = [ asyn streamdevice ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/harvardSyringe";
    ref = "master";
  };
  patches = [ ];
}
