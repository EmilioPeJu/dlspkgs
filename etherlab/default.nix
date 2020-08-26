{ epicsRepoBaseUrl, stdenv, linuxPackages, autoconf, automake, libtool }:

stdenv.mkDerivation rec {
  name = "etherlab";
  nativeBuildInputs = [ autoconf automake libtool ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/etherlab";
    ref = "stable-1.5";
  };
  outputs = [ "out" "dev" ];
  patches = [ ./02-add-liberror.patch ./03-use-liberror.patch ];
  KERNELDIR =
    "${linuxPackages.kernel.dev}/lib/modules/${linuxPackages.kernel.modDirVersion}/build";
  preConfigure = ''
    touch ChangeLog
    autoreconf -i
  '';
  configureFlags = [
    "--with-linux-dir=${KERNELDIR}"
    "--prefix=$(out)"
    "--disable-8139too"
    "--disable-r8169"
    "--enable-generic"
  ];
  buildPhase = ''
    runHook preBuild
    make all modules
    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall
    make install
    make modules_install INSTALL_MOD_PATH=$out
    runHook postInstall
    mkdir $dev/lib
    cp -rf lib/*.h $dev/lib
    mkdir $dev/master
    cp -rf master/*.h $dev/master
    cp -f *.h $dev
  '';
}
