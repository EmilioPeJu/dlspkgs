{ buildPythonPackage, fetchPypi, setuptools-dso, numpy }:
buildPythonPackage rec {
  pname = "epicscorelibs";
  version = "7.0.3.99.4.0";
  buildInputs = [ setuptools-dso ];
  propagatedBuildInputs = [ numpy ];
  configurePhase = ''
    # dummy
  '';
  src = fetchPypi {
    inherit pname version;
    sha256 = "0228naw9mh7pkx0nww90mi8wmiqm45p1hs6j0vpg5z7mwv5bys6n";
  };
}
