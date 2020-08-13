{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-devIocStats";
  postConfigure = ''
    sed -i '/devIocStatsApp/d' Makefile
  '';
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/deviocstats";
    ref = "master";
  };
}
