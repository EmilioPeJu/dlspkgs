{ epicsRepoBaseUrl, stdenv, pymalcolm, bash }:

stdenv.mkDerivation rec {
  name = "TS-ML-MALC-01";
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/${name}"; };
  buildInputs = [ pymalcolm bash ];
  stMalcolm = builtins.toFile "st-malcolm" ''
    #!@bash@/bin/bash
    cd @out@
    ./@name@.yaml
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp -rf * $out/
    substituteAll $stMalcolm $out/bin/${name}
    chmod +x $out/bin/${name}
  '';
}
