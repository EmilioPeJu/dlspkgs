{ epicsRepoBaseUrl, fetchgit, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-sscan";
  extraEtc = ./etc;
  src = fetchgit {
    url = "https://github.com/epics-modules/sscan";
    rev = "R2-11-4";
    sha256 = "0kasa31b4nx64fh6kr3qrx30pc0fzxmk1cllji61fls2m0gxpgq6";
    fetchSubmodules = false;
  };
}
