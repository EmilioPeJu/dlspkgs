{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-calc";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/calc";
    ref = "dls-master";
  };
}
