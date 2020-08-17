{ epicsRepoBaseUrl, buildPythonPackage }:
buildPythonPackage rec {
  pname = "annotypes";
  version = "0.21";
  doCheck = false;
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/annotypes"; };
}
