{ epicsRepoBaseUrl, libxml2, buildEpicsModule, asyn, adcore
}:

buildEpicsModule {
  name = "adsimdetector";
  buildInputs = [ libxml2 asyn adcore ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/adsimdetector";
    ref = "dls-master";
  };
}
