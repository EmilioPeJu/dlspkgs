{ epicsRepoBaseUrl, buildPythonPackage }:
buildPythonPackage rec {
  pname = "dls_edm";
  version = "1";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/dls_edm";
    ref = "python3";
  };
  postInstall = ''
    cp -rf dls_edm/*.pkl $(toPythonPath $out)/dls_edm
  '';
}
