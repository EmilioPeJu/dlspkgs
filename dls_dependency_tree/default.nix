{ epicsRepoBaseUrl, buildPythonPackage, qt5, pyqt5, dls_ade }:
buildPythonPackage rec {
  pname = "dls_dependency_tree";
  version = "2.17";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/dls_dependency_tree";
    ref = "python3";
  };
  patches = [ ./dont-skip-adpython.patch ];
  preBuild = ''
    sed -i "s/== .\+//g" setup.cfg
    rm Pipfile*
  '';
  postInstall = ''
    cp dls_dependency_tree/*.ui $(toPythonPath $out)/dls_dependency_tree
  '';
  nativeBuildInputs = [ qt5.wrapQtAppsHook ];
  dontWrapQtApps = true;
  postFixup = ''
    wrapQtApp "$out/bin/dls-dependency-checker.py"
  '';
  propagatedBuildInputs = [ pyqt5 dls_ade ];
}
