{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "autosave";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/autosave";
    ref = "dls-master";
  };
  NIX_CFLAGS_COMPILE = "-Wno-error=format-security";
}
