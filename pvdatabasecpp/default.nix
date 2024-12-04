{ epicsRepoBaseUrl, buildEpicsModule, pvcommoncpp, pvdatacpp
, pvaccesscpp }:

buildEpicsModule rec {
  name = "pvdataepics-basecpp";
  buildInputs =
    [ pvcommoncpp pvdatacpp pvaccesscpp ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvdataepics-basecpp";
    ref = "dls-master";
  };
}
