{ pkgs ? import <nixpkgs> { }, dlspkgs ? import <dlspkgs> { } }:
with pkgs;
let
  entrypoint = writeScript "entrypoint.sh" ''
    #!${runtimeShell}
    export USER=epics_user
    ${dlspkgs.procServ}/bin/procServ -q -n ioc -i ^D^C --allow 7001 /bin/ioc
    ${dlspkgs.procServ}/bin/procServ -q -n malcolm -i ^D^C --allow 7002 /bin/malcolm
    # wait forever
    tail -f /dev/null
  '';
in dockerTools.buildImage {
  name = "dls-test-ad-container";
  tag = "latest";
  runAsRoot = ''
    #!${runtimeShell}
    export PATH=/bin:/usr/bin:/sbin:/usr/sbin:$PATH
    ${dockerTools.shadowSetup}
    useradd -m epics_user
    mkdir /tmp
    chown epics_user /tmp
    chmod 777 /tmp
    ln -s ${runtimeShell} /bin/sh
  '';
  contents = [
    coreutils
    inetutils
    git
    dlspkgs.dls-epics-base
    dlspkgs.edm
    dlspkgs.TS-EA-IOC-01
    dlspkgs.TS-ML-MALC-01
    dlspkgs.procServ
  ];
  config = {
    EntryPoint = [ entrypoint ];
    User = "epics_user";
    ExposedPorts = {
      "6064/tcp" = { };
      "6064/udp" = { };
      "7001/tcp" = { };
      "7002/tcp" = { };
      "8008/tcp" = { };
    };
  };
}
