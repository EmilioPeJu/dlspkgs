{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-sscan";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/sscan";
    ref = "dls-master";
  };
}
