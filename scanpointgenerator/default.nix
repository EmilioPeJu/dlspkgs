{ epicsRepoBaseUrl, buildPythonPackage, nose, numpy, annotypes, mock }:
buildPythonPackage rec {
  pname = "scanpointgenerator";
  version = "3.1";
  buildInputs = [ nose mock ];
  propagatedBuildInputs = [ numpy annotypes ];
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/scanpointgenerator"; };
}
