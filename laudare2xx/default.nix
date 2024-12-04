{ epicsRepoBaseUrl, buildEpicsModule, asyn, streamdevice
, busy }:

buildEpicsModule {
  name = "laudare2xx";
  buildInputs = [ asyn streamdevice busy ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/laudare2xx";
    ref = "master";
  };
  patches = [ ];
}
