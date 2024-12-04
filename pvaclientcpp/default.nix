{ epicsRepoBaseUrl, buildEpicsModule, pvdatacpp
, normativetypescpp, pvaccesscpp }:

buildEpicsModule rec {
  name = "pvaclientcpp";
  buildInputs =
    [ pvdatacpp normativetypescpp pvaccesscpp ];
  preConfigure = ''
    sed -i 's/EPICS_//g' configure/RELEASE.local
  '';
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvaclientcpp";
    ref = "dls-master";
  };
}
