{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-pvdatacpp
, dls-epics-normativetypescpp, dls-epics-pvaccesscpp }:

buildEpicsModule rec {
  name = "dls-epics-pvaclientcpp";
  buildInputs =
    [ dls-epics-pvdatacpp dls-epics-normativetypescpp dls-epics-pvaccesscpp ];
  preConfigure = ''
    sed -i 's/EPICS_//g' configure/RELEASE.local
  '';
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvaclientcpp";
    ref = "dls-master";
  };
}
