{ pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz") { }
, epicsRepoBaseUrl ? "https://github.com/hir12111/" }:

with pkgs; rec {
  buildEpicsModule = callPackage ./dls-epics-modules/generic {
    inherit dls-epics-base patch-configure;
  };
  dls-epics-base = callPackage ./dls-epics-base { inherit epicsRepoBaseUrl; };
  patch-configure = callPackage ./patch-configure { };
  hdf5_filters = callPackage ./hdf5_filters { inherit epicsRepoBaseUrl; };
  edm = callPackage ./edm {
    inherit epicsRepoBaseUrl dls-epics-base patch-configure;
  };
  dls-epics-sscan = callPackage ./dls-epics-sscan {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls-epics-calc =
    callPackage ./dls-epics-calc { inherit epicsRepoBaseUrl buildEpicsModule; };
  dls-epics-asyn =
    callPackage ./dls-epics-asyn { inherit epicsRepoBaseUrl buildEpicsModule; };
  dls-epics-busy = callPackage ./dls-epics-busy {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn;
  };
  dls-epics-adsupport = callPackage ./dls-epics-adsupport {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls-epics-pvcommon = callPackage ./dls-epics-pvcommon {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls-epics-pvdata = callPackage ./dls-epics-pvdata {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvcommon;
  };
  dls-epics-normativetypes = callPackage ./dls-epics-normativetypes {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvcommon
      dls-epics-pvdata;
  };
  dls-epics-pvaccess = callPackage ./dls-epics-pvaccess {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvcommon
      dls-epics-pvdata;
  };
  dls-epics-pvdatabase = callPackage ./dls-epics-pvdatabase {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvcommon
      dls-epics-pvdata dls-epics-pvaccess;
  };
  dls-epics-pvaclient = callPackage ./dls-epics-pvaclient {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvdata
      dls-epics-normativetypes dls-epics-pvaccess;
  };
  dls-epics-adcore = callPackage ./dls-epics-adcore {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn dls-epics-busy
      dls-epics-sscan dls-epics-calc dls-epics-adsupport dls-epics-pvdata
      dls-epics-normativetypes dls-epics-pvaccess dls-epics-pvdatabase
      hdf5_filters;
  };
  dls-epics-adsimdetector = callPackage ./dls-epics-adsimdetector {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn dls-epics-adcore;
  };
  dls-epics-ffmpegserver = callPackage ./dls-epics-ffmpegserver {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn dls-epics-adcore
      dls-epics-adsimdetector;
  };
  dls-epics-aravisgige = callPackage ./dls-epics-aravisgige {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn dls-epics-adcore;
  };
  dls-epics-streamdevice = callPackage ./dls-epics-streamdevice {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn;
  };
  dls-epics-pvlogging = callPackage ./dls-epics-pvlogging {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls-epics-adpython = callPackage ./dls-epics-adpython {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn dls-epics-adcore;
  };
  dls-epics-gensub = callPackage ./dls-epics-gensub {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls-epics-seq =
    callPackage ./dls-epics-seq { inherit epicsRepoBaseUrl buildEpicsModule; };
  dls-epics-motor = callPackage ./dls-epics-motor {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-busy dls-epics-asyn;
  };
  dls-epics-pmac = callPackage ./dls-epics-pmac {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-calc dls-epics-busy
      dls-epics-asyn dls-epics-motor;
  };
  dls-epics-simhdf5detector = callPackage ./dls-epics-simhdf5detector {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn dls-epics-adcore;
  };
  dls-epics-gdaplugins = callPackage ./dls-epics-gdaplugins {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls_ade =
    python3Packages.callPackage ./dls_ade { inherit epicsRepoBaseUrl pygelf; };
  pygelf = python3Packages.callPackage ./pygelf { };
  dls_dependency_tree = python3Packages.callPackage ./dls_dependency_tree {
    inherit epicsRepoBaseUrl dls_ade;
  };
  dls_edm = python3Packages.callPackage ./dls_edm { inherit epicsRepoBaseUrl; };
  iocbuilder = python3Packages.callPackage ./iocbuilder {
    inherit epicsRepoBaseUrl dls-epics-base dls_dependency_tree dls_edm;
  };
  dls-python = python3.withPackages
    (pp: with pp; [ dls_ade dls_dependency_tree dls_edm iocbuilder ]);
  dls-python-env = buildEnv {
    name = "dls-python-env";
    ignoreCollisions = true;
    pathsToLink = [ "/bin" ];
    paths = [ dls-python ];
    postBuild = ''
      mv $out/bin/python $out/bin/dls-python
      rm $out/bin/py*
    '';
  };
  dls = buildEnv {
    name = "dls";
    ignoreCollisions = true;
    pathsToLink = [ "/bin" ];
    paths = [
      dls-epics-base
      patch-configure
      dls-epics-sscan
      dls-epics-asyn
      dls-epics-busy
      dls-epics-busy
      dls-epics-adsupport
      dls-epics-adcore
      dls-epics-adsimdetector
      dls-epics-pvcommon
      dls-epics-pvdata
      dls-epics-pvaccess
      dls-epics-normativetypes
      dls-epics-pvaclient
      dls-epics-ffmpegserver
      dls-epics-aravisgige
      dls-epics-streamdevice
      dls-epics-pvlogging
      dls-epics-adpython
      dls-epics-gensub
      dls-epics-seq
      dls-epics-motor
      dls-epics-pmac
      dls-epics-simhdf5detector
      dls-epics-gdaplugins
      edm
      dls-python
    ];
    postBuild = ''
      mv $out/bin/python $out/bin/dls-python
      rm $out/bin/py*
    '';
  };
}
