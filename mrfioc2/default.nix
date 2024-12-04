{ stdenv, linuxPackages, mrfioc2 }:

stdenv.mkDerivation rec {
  name = "mrfioc2";
  src = mrfioc2.src;
  dontConfigure = true;
  KERNELDIR =
    "${linuxPackages.kernel.dev}/lib/modules/${linuxPackages.kernel.modDirVersion}/build";
  buildPhase = ''
    runHook preBuild
    cd mrmShared/linux/
    make modules
    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall
    make modules_install INSTALL_MOD_PATH=$out
    runHook postInstall
  '';
}
