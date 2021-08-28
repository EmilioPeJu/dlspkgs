{ fetchgit, buildEpicsModule, dls-epics-devlib2 }:

buildEpicsModule {
  name = "dls-epics-mrfioc";
  buildInputs = [ dls-epics-devlib2 ];
  src = fetchgit {
    url = "https://github.com/epics-modules/mrfioc2";
    rev = "2.3.0";
    sha256 = "1xbxjh041dacv1vp3sbls141dxam2gdq28acz4pmyw46hp4drs05";
    fetchSubmodules = false;
  };
  extraEtc = ./etc;
}
