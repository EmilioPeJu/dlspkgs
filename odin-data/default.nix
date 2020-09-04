{ stdenv, fetchgit, hdf5, cmake, boost, zeromq, log4cxx, c-blosc, libpcap
, rdkafka, git }:

stdenv.mkDerivation rec {
  name = "odin-data";
  version = "1.4.0-gitmaster";
  src = builtins.fetchGit {
    url = "https://github.com/odin-detector/odin-data.git";
  };
  patches = [ ./find-system-hdf5hl.patch ];
  preConfigure = ''
    sed -i 's/git_describe(GIT_DESC_STR)/set(GIT_DESC_STR "${version}")/' CMakeLists.txt
  '';
  buildInputs = [ hdf5 cmake boost zeromq log4cxx c-blosc libpcap rdkafka git ];
}
