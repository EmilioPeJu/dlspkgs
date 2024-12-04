{ epicsRepoBaseUrl, buildEpicsModule }:

buildEpicsModule {
  name = "adsupport";
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/adsupport";
    ref = "dls-master";
  };
  preConfigure = ''
    cat << EOF >  configure/CONFIG_SITE.linux-x86_64.Common
    CROSS_COMPILER_TARGET_ARCHS =
    WITH_HDF5     = NO
    WITH_SZIP     = NO
    WITH_JPEG     = NO
    WITH_TIFF     = NO
    WITH_XML2     = NO
    WITH_ZLIB     = NO
    ZLIB_EXTERNAL = NO
    WITH_BLOSC    = NO
    WITH_CBF      = YES
    CBF_EXTERNAL  = NO
    EOF
  '';
}
