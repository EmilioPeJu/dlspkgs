{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-pvcommon }:

buildEpicsModule rec {
  name = "dls-epics-pvdata";
  buildInputs = [ dls-epics-pvcommon ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvdatacpp";
    ref = "dls-master";
  };
}
