{ buildEpicsModule, python3, ncurses }:

buildEpicsModule rec {
  name = "pythonioc";
  EPICS_HOST_ARCH = "linux-x86_64";
  buildInputs = [ ncurses python3 ];
  src =
    builtins.fetchGit { url = "https://github.com/dls-controls/pythonIoc"; };
  patches = [ ./use-normal-python.patch ];
  installPhase = ''
    mkdir $out
    cp -rf * $out
    cd $out
    make
  '';
}
