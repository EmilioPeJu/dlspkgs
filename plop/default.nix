{ buildPythonPackage, fetchPypi, tornado, six }:
buildPythonPackage rec {
  pname = "plop";
  version = "0.4.0";
  doCheck = false;
  propagatedBuildInputs = [ tornado six ];
  src = fetchPypi {
    inherit pname version;
    sha256 = "0f81z4f42rdc5ys652rc3aimwmdaissqffvr684b2ssgwg13qn1b";
  };
}
