{ epicsRepoBaseUrl, buildPythonPackage, dls-epics-base, qt5, pyqt5
, dls_dependency_tree, dls_edm, git }:
buildPythonPackage rec {
  pname = "iocbuilder";
  version = "3";
  patches = [
    ./fix-undefined-symbols.patch
    ./no-patch-arch.patch
    ./fix-export-modules.patch
    ./pva-from-epics-base.patch
  ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/iocbuilder";
    ref = "python3";
  };
  postInstall = ''
    cp -rf iocbuilder/defaults $(toPythonPath $out)/iocbuilder
  '';
  buildInputs = [ dls-epics-base ];
  nativeBuildInputs = [ qt5.wrapQtAppsHook ];
  dontWrapQtApps = true;
  postFixup = ''
    wrapQtApp "$out/bin/xeb"
  '';
  propagatedBuildInputs =
    [ pyqt5 dls-epics-base dls_dependency_tree dls_edm git ];
}
