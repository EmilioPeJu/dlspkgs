{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule rec {
  name = "dls-epics-pvcommon";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvcommoncpp";
    ref = "dls-master";
  };
}
