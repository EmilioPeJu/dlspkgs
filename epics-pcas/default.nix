{ buildEpicsModule }:

buildEpicsModule {
  name = "epics-pcas";
  src = builtins.fetchGit { url = "https://github.com/epics-modules/pcas"; };
}
