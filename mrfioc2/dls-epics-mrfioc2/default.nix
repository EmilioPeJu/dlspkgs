{ fetchgit, buildEpicsModule, devlib2 }:

buildEpicsModule {
  name = "mrfioc";
  buildInputs = [ devlib2 ];
  src = fetchgit {
    url = "https://github.com/epics-modules/mrfioc2";
    rev = "a8cb48d549b7aae13206cf2d168c6f1cfec2e1c4";
    sha256 = "0387nmnbm8528a3rgbgl3njjlxdcinlf0lnjhynd1qr8sxprpbx4";
    fetchSubmodules = false;
  };
  extraEtc = ./etc;
}
