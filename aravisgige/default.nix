{ epicsRepoBaseUrl, glib, libxml2, zlib, pkg-config, intltool, buildEpicsModule
, asyn, adcore }:

buildEpicsModule {
  name = "aravisgige";
  buildInputs = [
    pkg-config
    glib.out
    glib.dev
    libxml2.dev
    zlib
    intltool
    asyn
    adcore
  ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/aravisGigE";
    ref = "dls-master";
  };
  patches = [ ./correct-glib-path.patch ./builder-to-py3.patch ];
  postConfigure = ''
    cat << EOF >> configure/CONFIG_SITE
    CHECK_RELEASE = YES
    GLIBPREFIX=${glib.out}
    GLIBDEVPREFIX=${glib.dev}
    USR_INCLUDES += -I\$(GLIBPREFIX)/lib/glib-2.0/include  -I\$(GLIBDEVPREFIX)/include/glib-2.0
    EOF
    export ARAVIS_CFLAGS="-I${zlib}/include -I${libxml2.dev}/include/libxml2 -I${glib.out}/lib/glib-2.0/include -I${glib.dev}/include/glib-2.0"
    export ARAVIS_LIBS="-lz -lxml2 -lglib-2.0 -lgobject-2.0 -lgio-2.0 -lgmodule-2.0"
  '';
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -rf * $out
    cd $out
    make
    rm -rf aravisGigEApp
    find . \( -name '*.c' -or -name '*.cc' -or -name '*.cpp' -or -name '*.o' \) -exec rm {} \;
    runHook postInstall
  '';
}
