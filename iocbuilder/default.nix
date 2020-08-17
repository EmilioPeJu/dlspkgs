{ epicsRepoBaseUrl, buildPythonPackage, dls-epics-base, qt5, pyqt5
, dls_dependency_tree, dls_edm }:
buildPythonPackage rec {
  pname = "iocbuilder";
  version = "3";
  patches = [
    ./fix-undefined-symbols.patch
    ./no-patch-arch.patch
    ./fix-export-modules.patch
  ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/iocbuilder";
    ref = "python3";
  };
  postInstall = ''
    cp -rf iocbuilder/defaults $(toPythonPath $out)/iocbuilder
  '';
  buildInputs = [ dls-epics-base ];
  propagatedBuildInputs =
    [ qt5.full pyqt5 dls-epics-base dls_dependency_tree dls_edm ];
}
