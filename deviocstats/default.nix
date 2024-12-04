{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "devIocStats";
  postConfigure = ''
    sed -i '/devIocStatsApp/d' Makefile
  '';
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/deviocstats";
    ref = "master";
  };
}
