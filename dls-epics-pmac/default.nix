{ epicsRepoBaseUrl, fetchgit, boost, libssh2, buildEpicsModule, dls-epics-calc
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
  src = fetchgit {
    url = "https://github.com/dls-controls/pmac";
    rev = "2-5-3";
    sha256 = "0fw5f0pqav8kw2nwdv03v7938y056bldgyk059pv4nqg3yrykd20";
  };
  patches = [ ./disable-tests.patch ./ssh2-sys-lib.patch ];
}
