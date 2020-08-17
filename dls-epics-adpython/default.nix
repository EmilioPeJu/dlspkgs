{ epicsRepoBaseUrl, python, pythonPackages, buildEpicsModule, dls-epics-asyn
, dls-epics-adcore }:

buildEpicsModule {
  name = "dls-epics-adpython";
  buildInputs = [ python pythonPackages.numpy dls-epics-asyn dls-epics-adcore ];
  postConfigure = ''
    sed -i 's|PYTHON_PREFIX=.*|PYTHON_PREFIX=${python}|g' configure/RELEASE
  '';
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/adpython";
    ref = "master";
  };
  patches = [ ./builder-to-py3.patch ];
}
