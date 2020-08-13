{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-asyn }:

buildEpicsModule {
  name = "dls-epics-busy";
  buildInputs = [ dls-epics-asyn ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/busy";
    ref = "dls-master";
  };
}
