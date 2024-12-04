{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "pvlogging";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvlogging";
    ref = "master";
  };
}
