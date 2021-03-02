{ epicsRepoBaseUrl, buildPythonPackage, enum-compat, tornado, numpy, ruamel_yaml
, h5py, pygelf, plop, p4p, annotypes, cothread, scanpointgenerator, vdsgen, nose
, mock, pytest-timeout, ipython }:
buildPythonPackage rec {
  pname = "pymalcolm";
  version = "4.2";
  doCheck = false;
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/pymalcolm"; };
  buildInputs = [ nose mock pytest-timeout ];
  propagatedBuildInputs = [
    annotypes
    cothread
    enum-compat
    h5py
    ipython
    numpy
    p4p
    plop
    pygelf
    ruamel_yaml
    scanpointgenerator
    tornado
    vdsgen
  ];
}
