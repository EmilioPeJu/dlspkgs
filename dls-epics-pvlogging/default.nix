{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-pvlogging";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvlogging";
    ref = "master";
  };
}
