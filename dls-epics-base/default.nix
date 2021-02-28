{ epicsRepoBaseUrl, fetchgit, stdenv, perl, readline, lib, config }:

let dev = (config.dev or false);
in stdenv.mkDerivation {
  name = "dls-epics-base";
  src = builtins.fetchGit {
    url = if dev then
      "https://github.com/epics-base/epics-base.git"
    else
      "${epicsRepoBaseUrl}/epics-base";
    ref = if dev then "7.0" else "dls-7.0";
  };

  phases = [ "unpackPhase" "patchPhase" "installPhase" "fixupPhase" ];

  patches = [ ./no_abs_path_to_cc.patch ]
    ++ lib.optionals dev [ ./dls_templates.patch ];

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
