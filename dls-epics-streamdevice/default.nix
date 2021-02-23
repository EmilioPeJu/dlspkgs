{ epicsRepoBaseUrl, readline, buildEpicsModule, dls-epics-asyn }:

buildEpicsModule {
  name = "dls-epics-streamdevice";
  buildInputs = [ readline dls-epics-asyn ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/streamdevice";
    ref = "dls-master";
  };
}
