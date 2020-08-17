{ epicsRepoBaseUrl, buildPythonPackage, nose, mock, h5py }:
buildPythonPackage rec {
  pname = "vdsgen";
  version = "0.5.2";
  buildInputs = [ nose mock ];
  propagatedBuildInputs = [ h5py ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/vds-gen";
    ref = "refs/tags/0-5-2";
  };
}
