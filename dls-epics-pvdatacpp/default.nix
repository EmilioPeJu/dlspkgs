{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-pvcommoncpp }:

buildEpicsModule rec {
  name = "dls-epics-pvdatacpp";
  buildInputs = [ dls-epics-pvcommoncpp ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvdatacpp";
    ref = "dls-master";
  };
}
