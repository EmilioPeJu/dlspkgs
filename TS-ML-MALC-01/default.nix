{ epicsRepoBaseUrl, stdenv, pymalcolm }:

stdenv.mkDerivation rec {
  name = "TS-ML-MALC-01";
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/${name}"; };
  buildInputs = [ pymalcolm ];
  runtimeShell = stdenv.shell;
  stMalcolm = builtins.toFile "st-malcolm" ''
    #!@runtimeShell@
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
