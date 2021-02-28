{ pkgs ? (import <nixpkgs> { })
, epicsRepoBaseUrl ? "https://github.com/hir12111/", config ? { } }:

with pkgs;
let
  oldh5py = python3Packages.h5py.overrideAttrs (oldAttrs: {
    src = python3Packages.fetchPypi {
      pname = "h5py";
      version = "2.9.0";
      sha256 = "00hhh9iibd7jzq0mfriaivhqwf64r3j6b1xb2mjnnvgkv9iclhcx";
    };
  });
in rec {
  buildEpicsModule = callPackage ./dls-epics-modules/generic {
    inherit dls-epics-base patch-configure;
  };
  dls-epics-base =
    callPackage ./dls-epics-base { inherit epicsRepoBaseUrl config; };
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
  dls-epics-pvcommoncpp = callPackage ./dls-epics-pvcommoncpp {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls-epics-pvdatacpp = callPackage ./dls-epics-pvdatacpp {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvcommoncpp;
  };
  dls-epics-normativetypescpp = callPackage ./dls-epics-normativetypescpp {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvcommoncpp
      dls-epics-pvdatacpp;
  };
  dls-epics-pvaccesscpp = callPackage ./dls-epics-pvaccesscpp {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvcommoncpp
      dls-epics-pvdatacpp;
  };
  dls-epics-pvdatabasecpp = callPackage ./dls-epics-pvdatabasecpp {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvcommoncpp
      dls-epics-pvdatacpp dls-epics-pvaccesscpp;
  };
  dls-epics-pvaclientcpp = callPackage ./dls-epics-pvaclientcpp {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-pvdatacpp
      dls-epics-normativetypescpp dls-epics-pvaccesscpp;
  };
  dls-epics-adcore = callPackage ./dls-epics-adcore {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn dls-epics-busy
      dls-epics-sscan dls-epics-calc dls-epics-adsupport dls-epics-pvdatacpp
      dls-epics-normativetypescpp dls-epics-pvaccesscpp dls-epics-pvdatabasecpp
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
  dls-epics-harvardsyringe = callPackage ./dls-epics-harvardsyringe {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn
      dls-epics-streamdevice;
  };
  dls-epics-simhdf5detector = callPackage ./dls-epics-simhdf5detector {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn dls-epics-adcore;
  };
  dls-epics-gdaplugins = callPackage ./dls-epics-gdaplugins {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls-epics-adutil = callPackage ./dls-epics-adutil {
    inherit epicsRepoBaseUrl buildEpicsModule dls-epics-asyn dls-epics-adcore
      dls-epics-ffmpegserver dls-epics-adsimdetector;
  };
  dls-epics-autosave = callPackage ./dls-epics-autosave {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls-epics-deviocstats = callPackage ./dls-epics-deviocstats {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  dls-epics-ethercat = callPackage ./dls-epics-ethercat {
    inherit buildEpicsModule etherlab dls-epics-asyn dls-epics-busy;
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
  plop = python3Packages.callPackage ./plop { };
  setuptools-dso = python3Packages.callPackage ./setuptools-dso { };
  epicscorelibs =
    python3Packages.callPackage ./epicscorelibs { inherit setuptools-dso; };
  p4p =
    python3Packages.callPackage ./p4p { inherit setuptools-dso epicscorelibs; };
  annotypes =
    python3Packages.callPackage ./annotypes { inherit epicsRepoBaseUrl; };
  cothread = python3Packages.callPackage ./cothread {
    inherit epicsRepoBaseUrl dls-epics-base;
  };
  scanpointgenerator = python3Packages.callPackage ./scanpointgenerator {
    inherit epicsRepoBaseUrl annotypes;
  };
  vdsgen = python3Packages.callPackage ./vdsgen {
    inherit epicsRepoBaseUrl;
    h5py = oldh5py;
  };
  pymalcolm = python3Packages.callPackage ./pymalcolm {
    inherit epicsRepoBaseUrl pygelf plop p4p annotypes cothread
      scanpointgenerator vdsgen;
    h5py = oldh5py;
  };
  etherlab = callPackage ./etherlab { inherit epicsRepoBaseUrl; };
  odin-data = callPackage ./odin-data { };
  TS-EA-IOC-01 = callPackage ./TS-EA-IOC-01 {
    inherit epicsRepoBaseUrl dls-epics-base edm iocbuilder patch-configure
      dls-epics-adsimdetector dls-epics-motor dls-epics-adutil
      dls-epics-adpython dls-epics-simhdf5detector dls-epics-deviocstats;
  };
  TS-EA-IOC-02 = callPackage ./ioc-harvardsyringe {
    inherit epicsRepoBaseUrl dls-epics-base edm iocbuilder patch-configure
      dls-epics-asyn dls-epics-streamdevice dls-epics-harvardsyringe;
    config = (config.TS-EA-IOC-02 or { });
  };
  ioc-harvardsyringe = callPackage ./ioc-harvardsyringe {
    inherit epicsRepoBaseUrl dls-epics-base edm iocbuilder patch-configure
      dls-epics-asyn dls-epics-streamdevice dls-epics-harvardsyringe;
    config = (config.ioc-harvardsyringe or { });
  };
  TS-ML-MALC-01 =
    callPackage ./TS-ML-MALC-01 { inherit epicsRepoBaseUrl pymalcolm; };
  procServ = callPackage ./procServ { };
  ioc-example = callPackage ./ioc-example { inherit dls-epics-base; };
  dls-python = python3.withPackages (pp:
    with pp; [
      dls_ade
      dls_dependency_tree
      dls_edm
      iocbuilder
      cothread
      pymalcolm
    ]);
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
}
