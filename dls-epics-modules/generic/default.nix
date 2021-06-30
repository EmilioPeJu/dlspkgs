{ stdenv, dls-epics-base, patch-configure }:
{ buildInputs ? [ ], installPhase ? "", ... }@args:
let
  newargs = args // {
    buildInputs = [ dls-epics-base patch-configure ] ++ buildInputs;
    configurePhase = ''
      runHook preConfigure
      # make sure RELEASE.local gets included
      echo '-include $(TOP)/configure/RELEASE.local' > configure/RELEASE
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
       # avoid cross-compiler targets
      [ -f configure/CONFIG_SITE ] &&
        sed -i '/CROSS_COMPILER_TARGET_ARCHS/d' configure/CONFIG_SITE
      [ -f configure/CONFIG ] &&
        sed -i '/CROSS_COMPILER_TARGET_ARCHS/d' configure/CONFIG
      if [[ -n $extraEtc ]]; then
        mkdir -p etc
        # copy extra etc stuff
        cp -rf $extraEtc/* etc/
      fi
      if [[ -n $extraEdl ]]; then
        pushd *App &&
        mkdir -p edl &&
        cp -rf $extraEdl/* op/edl/
        popd
      fi
      if [[ -n $extraDb ]]; then
        pushd *App &&
        mkdir -p Db &&
        cp -rf $extraDb/* Db/
        popd
      fi
      if [[ -f configure/RULES ]]; then
          # include rules to copy files to data folder
          sed -i '1i-include $(CONFIG)/RULES.Dls' configure/RULES
      fi
      if [[ -f configure/CONFIG ]]; then
          # include config to copy files to data folder
          sed -i '/include $(CONFIG)\/CONFIG/a-include $(CONFIG)/CONFIG.Dls' \
            configure/CONFIG
      fi
      runHook postConfigure
    '';

    buildPhase = "# Dummy, it is done as part of installPhase";

    installPhase = if installPhase == "" then ''
      runHook preInstall
      make INSTALL_LOCATION=$out
      mkdir -p $out/bin
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
