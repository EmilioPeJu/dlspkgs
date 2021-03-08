{ buildEpicsModule, epics-pcas }:

buildEpicsModule {
  name = "epics-ca-gateway";
  buildInputs = [ epics-pcas ];
  src = builtins.fetchGit {
    url = "https://github.com/epics-extensions/ca-gateway";
  };
}
