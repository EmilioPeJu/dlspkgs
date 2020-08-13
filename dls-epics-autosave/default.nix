{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-autosave";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/autosave";
    ref = "dls-master";
  };
  NIX_CFLAGS_COMPILE = "-Wno-error=format-security";
}
