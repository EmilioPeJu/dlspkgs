{ epicsRepoBaseUrl, buildEpicsModule, doxygen }:

buildEpicsModule {
  name = "dls-epics-asyn";
  buildInputs = [ doxygen ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/asyn";
    ref = "dls-master";
  };
}
