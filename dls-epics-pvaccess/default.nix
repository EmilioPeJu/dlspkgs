{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-pvcommon, dls-epics-pvdata }:

buildEpicsModule rec {
  name = "dls-epics-pvaccess";
  buildInputs = [ dls-epics-pvcommon dls-epics-pvdata ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvaccesscpp";
    ref = "dls-master";
  };
}
