{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "gensub";
  patches = [ ./fix-build.patch ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/genSub";
    ref = "master";
  };
}
