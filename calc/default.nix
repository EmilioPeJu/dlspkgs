{ epicsRepoBaseUrl, fetchgit, buildEpicsModule }:

buildEpicsModule {
  name = "calc";
  extraEtc = ./etc;
  src = fetchgit {
    url = "https://github.com/epics-modules/calc";
    rev = "R3-7-4";
    sha256 = "14kbrv72cfsavvk5la3m33h9cbhia1n6lywh0ng300qqmlrkv43i";
  };
}
