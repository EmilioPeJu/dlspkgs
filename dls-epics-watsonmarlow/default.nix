{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-asyn, dls-epics-streamdevice }:

buildEpicsModule {
  name = "dls-epics-watsonmarlow";
  buildInputs = [ dls-epics-asyn dls-epics-streamdevice ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/watson-marlow";
    ref = "master";
  };
  patches = [ ];
}
