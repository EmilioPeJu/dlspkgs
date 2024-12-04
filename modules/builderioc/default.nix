{ stdenv, epics-base, patch-configure, iocbuilder, edm }:
{ name, iocXml, buildInputs ? [ ], installPhase ? "", ... }@args:
let
  newargs = args // {
    buildInputs = [ epics-base patch-configure iocbuilder edm ]
      ++ buildInputs;

    phases = [ "configurePhase" "buildPhase" "installPhase" "fixupPhase" ];

    configurePhase = ''
      runHook preConfigure
      mkdir source
      cd source
      echo EPICS_BASE= > ${name}_RELEASE
      # include build dependencies related to EPICS
      for dep in $buildInputs; do
        if [[ "$dep" == *epics* ]]; then
          module="''${dep##*-}"
          if [[ "$module" == "epics-base" ]]; then
            continue
          fi
          module_upper="''${module^^}"
          echo ''${module_upper}= >> ${name}_RELEASE
        fi
      done
      patch-configure ${name}_RELEASE
      pwd
      cat ${name}_RELEASE
      chmod +rw ${name}_RELEASE
      cp ${iocXml} ${name}.xml
      chmod +rw ${name}.xml
      runHook postConfigure
    '';

    runtimeShell = stdenv.shell;
    stGui = builtins.toFile "st-gui" ''
      #!@runtimeShell@
      cd @out@/${name}/bin/linux-x86_64
      ./st@name@-gui "$@"
    '';
    stIoc = builtins.toFile "st-ioc" ''
      #!@runtimeShell@
      cd @out@/${name}/bin/linux-x86_64
      ./st@name@.sh "$@"
    '';

    buildPhase = ''
      dls-xml-iocbuilder.py -e -o ./ ./${name}.xml
      substituteInPlace \
          ./${name}/${name}App/opi/edl/st${name}-gui --replace 'edm' \
          '${edm}/bin/edm'
    '';

    installPhase = ''
      mkdir $out
      mkdir $out/bin
      cp -rf ${name} $out/
      make -C $out/${name}
      substituteAll $stGui $out/bin/${name}-gui
      chmod +x $out/bin/${name}-gui
      substituteAll $stIoc $out/bin/${name}.sh
      chmod +x $out/bin/${name}.sh
    '';
  };
in stdenv.mkDerivation newargs
