{ epicsRepoBaseUrl, buildEpicsModule, asyn, streamdevice }:

buildEpicsModule {
  name = "watsonmarlow";
  buildInputs = [ asyn streamdevice ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/watson-marlow";
    ref = "master";
  };
  patches = [ ];
}
