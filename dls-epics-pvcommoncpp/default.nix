{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule rec {
  name = "dls-epics-pvcommoncpp";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvcommoncpp";
    ref = "dls-master";
  };
}
