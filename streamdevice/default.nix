{ epicsRepoBaseUrl, fetchgit, readline, pcre, buildEpicsModule, asyn
}:

buildEpicsModule {
  name = "streamdevice";
  buildInputs = [ readline asyn pcre.out pcre.dev ];
  NIX_CFLAGS_COMPILE = "-Wno-error=format-security";
  extraEtc = ./etc;
  src = fetchgit {
    url = "https://github.com/paulscherrerinstitute/StreamDevice";
    rev = "2.8.19";
    sha256 = "1pfyxb6l9aqmy4kpsm3iz2j23rpjiwgqmk65jb5k3c89d193ml2i";
  };
  postConfigure = ''
    cat <<EOF >> configure/RELEASE.local
    PCRE_INCLUDE=${pcre.dev}/include
    PCRE_LIB=${pcre.out}/lib
    EOF
  '';
}
