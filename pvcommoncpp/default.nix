{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule rec {
  name = "pvcommoncpp";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvcommoncpp";
    ref = "dls-master";
  };
}
