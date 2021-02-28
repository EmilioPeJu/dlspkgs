{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-asyn, dls-epics-streamdevice
, dls-epics-busy }:

buildEpicsModule {
  name = "dls-epics-laudare2xx";
  buildInputs = [ dls-epics-asyn dls-epics-streamdevice dls-epics-busy ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/laudare2xx";
    ref = "master";
  };
  patches = [ ];
}
