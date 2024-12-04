{ epicsRepoBaseUrl, fetchgit, boost, libssh2, buildEpicsModule, calc
, busy, asyn, motor }:

buildEpicsModule {
  name = "pmac";
  buildInputs = [
    boost
    libssh2
    calc
    busy
    asyn
    motor
  ];
  src = fetchgit {
    url = "https://github.com/dls-controls/pmac";
    rev = "2-5-3";
    sha256 = "0fw5f0pqav8kw2nwdv03v7938y056bldgyk059pv4nqg3yrykd20";
  };
  patches = [ ./disable-tests.patch ./ssh2-sys-lib.patch ];
}
