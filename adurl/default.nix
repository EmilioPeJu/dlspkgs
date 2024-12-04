{ epicsRepoBaseUrl, fetchgit, libxml2, imagemagick, buildEpicsModule, asyn, adcore }:

buildEpicsModule {
  name = "adurl";
  buildInputs = [ libxml2 imagemagick imagemagick.dev asyn adcore ];
  NIX_CFLAGS_COMPILE = "-I${imagemagick.dev}/include/ImageMagick";
  src = fetchgit {
    url = "https://github.com/areaDetector/ADURL";
    rev = "R2-3";
    sha256 = "sha256-Zz+eoZEKCLLqRpmiRVs9VWel7cPNnkMZkQfx2aCKLUU=";
  };
  patches = [
    ./use-sys-libs.patch
    ./fix-integer-pixel.patch
  ];
  extraEtc = ./etc;
  extraDb = ./Db;
  extraEdl = ./edl;
}
