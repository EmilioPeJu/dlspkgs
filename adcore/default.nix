{ epicsRepoBaseUrl, fetchgit, libxml2, buildEpicsModule, asyn
, busy, sscan, calc, adsupport
, hdf5_filters, hdf5, boost, c-blosc, libtiff, libjpeg, zlib, szip }:

buildEpicsModule rec {
  name = "adcore";
  buildInputs = [
    asyn
    busy
    sscan
    calc
    adsupport
    hdf5
    hdf5_filters
    boost
    c-blosc
    libtiff
    libjpeg
    zlib
    szip
  ];
  propagatedBuildInputs = [ libxml2.dev ];
  extraEtc = ./etc;
  extraDb = ./Db;
  extraEdl = ./edl;
  preConfigure = ''
    cat << EOF > configure/CONFIG_SITE.linux-x86_64.Common
    WITH_HDF5 = YES
    HDF5_EXTERNAL = YES
    WITH_BOOST = YES
    BOOST_EXTERNAL = YES
    WITH_XML2     = YES
    XML2_EXTERNAL = YES
    WITH_BLOSC    = YES
    BLOSC_EXTERNAL= YES
    XML2_INCLUDE = ${libxml2.dev}/include/libxml2
    WITH_JPEG = YES
    JPEG_EXTERNAL = YES
    WITH_TIFF     = YES
    TIFF_EXTERNAL = YES
    WITH_ZLIB     = YES
    ZLIB_EXTERNAL = YES
    WITH_SZIP = YES
    SZIP_EXTERNAL = YES
    # Enable PVA plugin
    WITH_PVA = YES
    WITH_QSRV     = NO
    EOF
  '';
  postConfigure = ''
    substituteInPlace etc/builder.py \
      --replace '@hdf5_filters@' '${hdf5_filters}'
  '';
  postInstall = ''
    mkdir -p $out/ADApp
    cp ADApp/common*Makefile $out/ADApp
  '';
  patches = [ ./fix-missing-parameter.patch ./make-op-edl.patch ];
  src = fetchgit {
    url = "https://github.com/areaDetector/ADCore";
    rev = "R3-11";
    sha256 = "1yr43hrxlnmwaddwakq6wxb1fx3irmzgw8xc618063x23gi3pnb0";
  };
}
