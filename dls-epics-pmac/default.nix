{ epicsRepoBaseUrl, boost, libssh2, buildEpicsModule, dls-epics-calc
, dls-epics-busy, dls-epics-asyn, dls-epics-motor }:

buildEpicsModule {
  name = "dls-epics-pmac";
  buildInputs = [
    boost
    libssh2
    dls-epics-calc
    dls-epics-busy
    dls-epics-asyn
    dls-epics-motor
  ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pmac";
    ref = "dls-master";
  };
  patches = [ ./disable-tests.patch ];
}
