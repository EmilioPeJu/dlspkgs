{ stdenv, autoconf, automake, libtool }:

stdenv.mkDerivation rec {
  name = "procServ";
  src =
    builtins.fetchGit { url = "https://github.com/ralphlange/procServ.git"; };
  phases =
    [ "unpackPhase" "patchPhase" "buildPhase" "installPhase" "fixupPhase" ];
  buildPhase = ''
    make
    ./configure --prefix=$out --disable-doc --enable-access-from-anywhere
    make
  '';
  installPhase = ''
    make install
  '';
  buildInputs = [ autoconf automake libtool ];
}
