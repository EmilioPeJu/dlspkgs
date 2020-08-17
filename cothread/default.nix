{ epicsRepoBaseUrl, buildPythonPackage, dls-epics-base, numpy }:
buildPythonPackage rec {
  pname = "cothread";
  version = "2.16";
  doCheck = false;
  propagatedBuildInputs = [ dls-epics-base numpy ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/cothread";
    ref = "refs/tags/2-16";
  };
}
