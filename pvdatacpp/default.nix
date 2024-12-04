{ epicsRepoBaseUrl, buildEpicsModule, pvcommoncpp }:

buildEpicsModule rec {
  name = "pvdatacpp";
  buildInputs = [ pvcommoncpp ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvdatacpp";
    ref = "dls-master";
  };
}
