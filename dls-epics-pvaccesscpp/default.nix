{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-pvcommoncpp, dls-epics-pvdatacpp
}:

buildEpicsModule rec {
  name = "dls-epics-pvaccesscpp";
  buildInputs = [ dls-epics-pvcommoncpp dls-epics-pvdatacpp ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvaccesscpp";
    ref = "dls-master";
  };
}
