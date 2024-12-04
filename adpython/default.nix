{ epicsRepoBaseUrl, python, pythonPackages, buildEpicsModule, asyn
, adcore }:

buildEpicsModule {
  name = "adpython";
  buildInputs = [ python pythonPackages.numpy asyn adcore ];
  postConfigure = ''
    sed -i 'aPYTHON_PREFIX=${python}' configure/RELEASE.local
  '';
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/adpython";
    ref = "master";
  };
  patches = [ ./builder-to-py3.patch ];
}
