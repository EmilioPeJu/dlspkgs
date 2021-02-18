{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-asyn, dls-epics-streamdevice }:

buildEpicsModule {
  name = "dls-epics-harvardsyringe";
  buildInputs = [
    dls-epics-asyn
    dls-epics-streamdevice
  ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/harvardSyringe";
    ref = "master";
  };
  patches = [ ];
}
