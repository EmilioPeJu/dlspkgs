{ buildPythonPackage, fetchPypi, cython }:
buildPythonPackage rec {
  pname = "setuptools_dso";
  version = "1.7";
  propagatedBuildInputs = [ cython ];
  src = fetchPypi {
    inherit pname version;
    sha256 = "0v01vjncchy1mkgk42vfdpj6qzdw5nrcqhldll57qi3byzfzm8lk";
  };
}
