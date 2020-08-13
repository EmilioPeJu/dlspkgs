{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-gensub";
  patches = [ ./fix-build.patch ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/genSub";
    ref = "master";
  };
}
