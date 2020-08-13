{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-gdaPlugins";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/gdaplugins";
    ref = "master";
  };
}
