{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-gdaplugins";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/gdaplugins";
    ref = "master";
  };
}
