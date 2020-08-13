{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-pvcommoncpp, dls-epics-pvdatacpp
, dls-epics-pvaccesscpp }:

buildEpicsModule rec {
  name = "dls-epics-pvdatabasecpp";
  buildInputs =
    [ dls-epics-pvcommoncpp dls-epics-pvdatacpp dls-epics-pvaccesscpp ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvdatabasecpp";
    ref = "dls-master";
  };
}
