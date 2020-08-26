{ epicsRepoBaseUrl, buildPythonPackage, enum-compat, tornado, numpy, ruamel_yaml
, h5py, pygelf, plop, p4p, annotypes, cothread, scanpointgenerator, vdsgen, nose
, mock, pytest-timeout }:
buildPythonPackage rec {
  pname = "pymalcolm";
  version = "4.2";
  doCheck = false;
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/pymalcolm"; };
  postConfigure = ''
    # relax version constraints a bit
    sed -i 's/==/>=/g' setup.py
    # you get enum34 from enum-compat
    sed -i '/enum34/d' setup.py
    # typing is free in python 3.7
    sed -i '/typing/d' setup.py
    sed -i 's/tornado>=5.1.1/tornado>=5.1/g' setup.py
  '';
  patches = [
    ./fix-cmd-string.patch
    ./include-web-content.patch
    ./disable-site-log-handlers.patch
  ];
  buildInputs = [ nose mock pytest-timeout ];
  propagatedBuildInputs = [
    enum-compat
    tornado
    numpy
    ruamel_yaml
    h5py
    pygelf
    plop
    p4p
    annotypes
    cothread
    scanpointgenerator
    vdsgen
  ];
}
