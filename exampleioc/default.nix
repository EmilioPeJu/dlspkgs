{ stdenv, dls-epics-base }:

stdenv.mkDerivation rec {
  name = "exampleioc";
  phases = [ "installPhase" ];
  installPhase = ''
    export T_A=$(perl $EPICS_BASE/lib/perl/EpicsHostArch.pl)
    export EPICS_HOST_ARCH=$T_A
    mkdir $out
    cd $out
    MBA=$EPICS_BASE/bin/$T_A/makeBaseApp.pl
    $MBA -u user -a $T_A -t example ${name}
    $MBA -u user -a $T_A -t example -i -p ${name} ${name}
    mkdir -p include
    cat <<EOF > include/${name}Version.h
    #define ${name}VERSION "0.0"
    EOF
    cat include/${name}Version.h
    # bypass a bug in makefiles
    # by calling make twice
    make || true
    make
    chmod +x $out/iocBoot/${name}/st.cmd
    cat <<EOF > bin/${name}
    #!/usr/bin/env bash
    cd $out/iocBoot/${name}
    if [[ "\$1" == "-d" ]]; then
      gdb --args ../../bin/$T_A/${name} st.cmd
    else
      ./st.cmd
    fi
    EOF
    chmod +x bin/${name}
  '';
  buildInputs = [ dls-epics-base ];
}
