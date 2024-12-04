{ epicsRepoBaseUrl, fetchgit, buildEpicsModule, busy, asyn
}:

buildEpicsModule {
  name = "motor";
  buildInputs = [ busy asyn ];
  extraEtc = ./etc;
  extraDb = ./Db;
  extraEdl = ./edl;
  src = fetchgit {
    url = "https://github.com/epics-modules/motor";
    rev = "R7-2-2";
    sha256 = "07lv2hw1hij5i00qlcnpy8cqypic5pyj4yn782kaddpkf28371jx";
    fetchSubmodules = true;
  };
  patches = [ ./build-edl-folder.patch ];
}
