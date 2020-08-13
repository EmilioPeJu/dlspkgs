{ stdenv, dls-epics-base, patch-configure }:
{ buildInputs ? [ ], installPhase ? "", ... }@args:
let
  newargs = args // {
    buildInputs = [ dls-epics-base patch-configure ] ++ buildInputs;

    configurePhase = ''
      runHook preConfigure
      # make sure RELEASE.local gets included
      echo '-include $(TOP)/configure/RELEASE.local' >> configure/RELEASE
      echo EPICS_BASE= > configure/RELEASE.local
      # include build dependencies related to EPICS
      for dep in $buildInputs; do
        if [[ "$dep" == *epics* ]]; then
          module="''${dep##*-}"
          if [[ "$module" == "base" ]]; then
            continue
          fi
          module_upper="''${module^^}"
          echo ''${module_upper}= >> configure/RELEASE.local
        fi
      done
      echo "Created RELEASE.local with:"
      cat configure/RELEASE.local
      # patch release files to point to dependencies to installation path
      for path in "configure/RELEASE" "configure/RELEASE.linux-x86_64.Common" "configure/RELEASE.linux-x86_64" "configure/RELEASE.local"; do
        if [ -f "$path" ]; then
          patch-configure "$path"
         fi
      done
      # don't make examples or docs
      if [ -f etc/Makefile ]; then
        sed -i /makeIocs/d etc/Makefile;
        sed -i /makeDocumentation/d etc/Makefile;
      fi
      if [ -f configure/CONFIG_SITE ]; then
        # avoid cross-compiler targets
        sed -i '/CROSS_COMPILER_TARGET_ARCHS/d' configure/CONFIG_SITE
      fi
      runHook postConfigure
    '';

    findSrc = builtins.toFile "find-epics" ''
      #!/usr/bin/env bash
      echo @out@
    '';

    buildPhase = "# Dummy, it is done as part of installPhase";

    installPhase = if installPhase == "" then ''
      runHook preInstall
      make INSTALL_LOCATION=$out
      mkdir -p $out/bin
      substituteAll $findSrc $out/bin/find-''${name,,}
      chmod +x $out/bin/find-''${name,,}
      for i in "etc" "data"; do
        if [ -d $i ]; then
          cp -rf $i $out
        fi
      done
      runHook postInstall
    '' else
      installPhase;

    meta.priority = 6;
  };
in stdenv.mkDerivation newargs
