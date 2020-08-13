{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-pvcommon, dls-epics-pvdata }:

buildEpicsModule rec {
  name = "dls-epics-normativetypes";
  buildInputs = [ dls-epics-pvcommon dls-epics-pvdata ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/normativetypescpp";
    ref = "dls-master";
  };
}
