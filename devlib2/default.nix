{ fetchgit, buildEpicsModule }:

buildEpicsModule {
  name = "devlib2";
  src = fetchgit {
    url = "https://github.com/epics-modules/devlib2";
    rev = "2.11";
    sha256 = "021iwj3gyvwah9p79d3fslnnkwb17d8h8yxg5mzjwmk00vr2zm21";
    fetchSubmodules = false;
  };
  patches = [ ./missing-include.patch ];
  extraEtc = ./etc;
}
