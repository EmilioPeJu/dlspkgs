{ epicsRepoBaseUrl, re2c, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-seq";
  buildInputs = [ re2c ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/seq";
    ref = "dls-master";
  };
}
