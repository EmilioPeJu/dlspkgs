{ epicsRepoBaseUrl, buildPythonPackage, epics-base, numpy, setuptools,
  setuptools_scm }:
buildPythonPackage rec {
  pname = "cothread";
  version = "2.20.0";
  pyproject = true;
  doCheck = false;
  propagatedBuildInputs = [ epics-base numpy setuptools setuptools_scm ];
  src = builtins.fetchGit {
    url = "https://github.com/DiamondLightSource/cothread.git";
    ref = "refs/tags/${version}";
  };
  postPatch = ''
    sed -i 's#libca_path = .*#libca_path = "${epics-base}/lib/linux-x86_64"#' \
      src/cothread/load_ca.py
  '';
}
