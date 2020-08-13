{ epicsRepoBaseUrl, libxml2, buildEpicsModule, dls-epics-asyn, dls-epics-busy
, dls-epics-sscan, dls-epics-calc, dls-epics-adsupport, dls-epics-pvdata
, dls-epics-normativetypes, dls-epics-pvaccess, dls-epics-pvdatabase
, hdf5_filters, hdf5, boost, c-blosc, libtiff, libjpeg, zlib, szip }:

buildEpicsModule rec {
  name = "dls-epics-adcore";
  buildInputs = [
    libxml2.dev
    dls-epics-asyn
    dls-epics-busy
    dls-epics-sscan
    dls-epics-calc
    dls-epics-adsupport
    dls-epics-pvdata
    dls-epics-normativetypes
    dls-epics-pvaccess
    dls-epics-pvdatabase
    hdf5
    hdf5_filters
    boost
    c-blosc
    libtiff
    libjpeg
    zlib
    szip
  ];
  preConfigure = ''
    # temporal fix to non standard variable names in release file
    sed -i 's/CPP//g' configure/RELEASE.local
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
  postInstall = ''
    mkdir -p $out/ADApp
    cp ADApp/common*Makefile $out/ADApp
  '';
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/adcore";
    ref = "dls-master";
  };
}
