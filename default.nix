{ pkgs ? (import <nixpkgs> { })
, epicsRepoBaseUrl ? "https://github.com/hir12111/", config ? { } }:

with pkgs; rec {
  buildEpicsModule = callPackage ./modules/generic {
    inherit epics-base patch-configure;
  };
  buildBuilderIoc = callPackage ./modules/builderioc {
    inherit epics-base patch-configure iocbuilder edm;
  };
  epics-base =
    callPackage ./epics-base { inherit epicsRepoBaseUrl config; };
  patch-configure = callPackage ./patch-configure { };
  hdf5_filters = callPackage ./hdf5_filters { inherit epicsRepoBaseUrl; };
  edm = callPackage ./edm {
    inherit epicsRepoBaseUrl epics-base patch-configure;
  };
  sscan = callPackage ./sscan {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  calc =
    callPackage ./calc { inherit epicsRepoBaseUrl buildEpicsModule; };
  asyn =
    callPackage ./asyn { inherit epicsRepoBaseUrl buildEpicsModule; };
  busy = callPackage ./busy {
    inherit epicsRepoBaseUrl buildEpicsModule asyn;
  };
  adsupport = callPackage ./adsupport {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  pvcommoncpp = callPackage ./pvcommoncpp {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  pvdatacpp = callPackage ./pvdatacpp {
    inherit epicsRepoBaseUrl buildEpicsModule pvcommoncpp;
  };
  normativetypescpp = callPackage ./normativetypescpp {
    inherit epicsRepoBaseUrl buildEpicsModule pvcommoncpp
      pvdatacpp;
  };
  pvaccesscpp = callPackage ./pvaccesscpp {
    inherit epicsRepoBaseUrl buildEpicsModule pvcommoncpp
      pvdatacpp;
  };
  pvdataepics-basecpp = callPackage ./pvdataepics-basecpp {
    inherit epicsRepoBaseUrl buildEpicsModule pvcommoncpp
      pvdatacpp pvaccesscpp;
  };
  pvaclientcpp = callPackage ./pvaclientcpp {
    inherit epicsRepoBaseUrl buildEpicsModule pvdatacpp
      normativetypescpp pvaccesscpp;
  };
  adcore = callPackage ./adcore {
    inherit epicsRepoBaseUrl buildEpicsModule asyn busy
      sscan calc adsupport hdf5_filters;
  };
  adsimdetector = callPackage ./adsimdetector {
    inherit epicsRepoBaseUrl buildEpicsModule asyn adcore;
  };
  adurl = callPackage ./adurl {
    inherit epicsRepoBaseUrl buildEpicsModule asyn adcore;
  };
  ffmpegserver = callPackage ./ffmpegserver {
    inherit epicsRepoBaseUrl buildEpicsModule adcore asyn;
  };
  aravisgige = callPackage ./aravisgige {
    inherit epicsRepoBaseUrl buildEpicsModule asyn adcore;
  };
  streamdevice = callPackage ./streamdevice {
    inherit epicsRepoBaseUrl buildEpicsModule asyn;
  };
  pvlogging = callPackage ./pvlogging {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  adpython = callPackage ./adpython {
    inherit epicsRepoBaseUrl buildEpicsModule asyn adcore;
  };
  gensub = callPackage ./gensub {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  seq =
    callPackage ./seq { inherit epicsRepoBaseUrl buildEpicsModule; };
  motor = callPackage ./motor {
    inherit epicsRepoBaseUrl buildEpicsModule busy asyn;
  };
  pmac = callPackage ./pmac {
    inherit epicsRepoBaseUrl buildEpicsModule calc busy
      asyn motor;
  };
  harvardsyringe = callPackage ./harvardsyringe {
    inherit epicsRepoBaseUrl buildEpicsModule asyn
      streamdevice;
  };
  laudare2xx = callPackage ./laudare2xx {
    inherit epicsRepoBaseUrl buildEpicsModule asyn
      streamdevice busy;
  };
  watsonmarlow = callPackage ./watsonmarlow {
    inherit epicsRepoBaseUrl buildEpicsModule asyn
      streamdevice;
  };
  simhdf5detector = callPackage ./simhdf5detector {
    inherit epicsRepoBaseUrl buildEpicsModule asyn adcore;
  };
  gdaplugins = callPackage ./gdaplugins {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  adutil = callPackage ./adutil {
    inherit epicsRepoBaseUrl buildEpicsModule asyn adcore
      ffmpegserver adsimdetector;
  };
  autosave = callPackage ./autosave {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  deviocstats = callPackage ./deviocstats {
    inherit epicsRepoBaseUrl buildEpicsModule;
  };
  ethercat = callPackage ./ethercat {
    inherit buildEpicsModule etherlab asyn busy;
  };
  devlib2 =
    callPackage ./devlib2 { inherit buildEpicsModule; };
  mrfioc2 = callPackage ./mrfioc2 {
    inherit buildEpicsModule devlib2;
  };
  mrfioc2 = callPackage ./mrfioc2 { inherit mrfioc2; };
  epics-ca-gateway =
    callPackage ./epics-ca-gateway { inherit buildEpicsModule epics-pcas; };
  epics-pcas = callPackage ./epics-pcas { inherit buildEpicsModule; };
  pygelf = python3Packages.callPackage ./pygelf { };
  dls_edm = python3Packages.callPackage ./dls_edm { inherit epicsRepoBaseUrl; };
  epicsdbbuilder = python3Packages.callPackage ./epicsdbbuilder {
    inherit epics-base epicscorelibs;
  };
  iocbuilder = python3Packages.callPackage ./iocbuilder {
    inherit epicsRepoBaseUrl epics-base dls_dependency_tree dls_edm;
  };
  plop = python3Packages.callPackage ./plop { };
  pythonioc = callPackage ./pythonioc { inherit buildEpicsModule; };
  setuptools-dso = python3Packages.callPackage ./setuptools-dso { };
  epicscorelibs =
    python3Packages.callPackage ./epicscorelibs { inherit setuptools-dso; };
  p4p =
    python3Packages.callPackage ./p4p { inherit setuptools-dso epicscorelibs; };
  annotypes =
    python3Packages.callPackage ./annotypes { inherit epicsRepoBaseUrl; };
  cothread = python3Packages.callPackage ./cothread {
    inherit epicsRepoBaseUrl epics-base;
  };
  scanpointgenerator = python3Packages.callPackage ./scanpointgenerator {
    inherit epicsRepoBaseUrl annotypes;
  };
  vdsgen = python3Packages.callPackage ./vdsgen { inherit epicsRepoBaseUrl; };
  pymalcolm = python3Packages.callPackage ./pymalcolm {
    inherit epicsRepoBaseUrl pygelf plop p4p annotypes cothread
      scanpointgenerator vdsgen;
  };
  etherlab = callPackage ./etherlab { inherit epicsRepoBaseUrl; };
  odin-data = callPackage ./odin-data { };
  procServ = callPackage ./procServ { };
  iocexample = callPackage ./iocexample { inherit epics-base; };
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
