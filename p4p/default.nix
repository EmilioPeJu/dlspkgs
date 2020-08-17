{ buildPythonPackage, fetchPypi, nose, setuptools-dso, numpy, epicscorelibs, ply
}:
buildPythonPackage rec {
  pname = "p4p";
  version = "3.5.2a1";
  buildInputs = [ nose setuptools-dso ];
  propagatedBuildInputs = [ epicscorelibs numpy ply ];
  src = fetchPypi {
    inherit pname version;
    sha256 = "1qzxs804f9hpnrj7kqwnsw6i7lqmgwfrkazrwqw994vk0p49mhfx";
  };
}
