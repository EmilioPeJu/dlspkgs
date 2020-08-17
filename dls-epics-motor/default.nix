{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-busy, dls-epics-asyn }:

buildEpicsModule {
  name = "dls-epics-motor";
  buildInputs = [ dls-epics-busy dls-epics-asyn ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/motor";
    ref = "dls-master";
  };
  patches = [ ./no-cross-compile.patch ./builder-to-py3.patch ];
}
