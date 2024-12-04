{ epicsRepoBaseUrl, re2c, buildEpicsModule }:

buildEpicsModule {
  name = "seq";
  buildInputs = [ re2c ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/seq";
    ref = "dls-master";
  };
}
