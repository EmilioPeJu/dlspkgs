{ epicsRepoBaseUrl, fetchgit, stdenv, perl, readline, lib, config }:

stdenv.mkDerivation {
  name = "dls-epics-base";
  src = fetchgit {
    url = "https://github.com/epics-base/epics-base.git";
    rev = "R7.0.5";
    sha256 = "1vzivgbpc6a6v1plxb75zjz15y410iz12lx622nj2xkw7i1wgnc1";
    fetchSubmodules = true;
  };

  phases = [ "unpackPhase" "patchPhase" "installPhase" "fixupPhase" ];

  patches = [ ./no_abs_path_to_cc.patch ./dls_templates.patch ];

  buildInputs = [ readline ];
  propagatedBuildInputs = [ perl ];

  setupHook = builtins.toFile "setupHook.sh" ''
    export EPICS_BASE='@out@'
  '';

  findSrc = builtins.toFile "find-epics" ''
    #!/usr/bin/env bash
    echo @out@
  '';

  configurePhase = "# nothing to do";
  buildPhase = ''
    # Dummy build phase, as it is done as part of installPhase
  '';

  installPhase = ''
    make INSTALL_LOCATION=$out
    substituteAll $findSrc $out/bin/find-$name
    chmod +x $out/bin/find-$name
    cd $out/bin
    for i in linux-x86_64/*; do
        ln -s "$i"
    done
  '';

  meta.priority = 4;
}
