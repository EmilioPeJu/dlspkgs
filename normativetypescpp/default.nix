{ epicsRepoBaseUrl, buildEpicsModule, pvcommoncpp, pvdatacpp
}:

buildEpicsModule rec {
  name = "normativetypescpp";
  buildInputs = [ pvcommoncpp pvdatacpp ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/normativetypescpp";
    ref = "dls-master";
  };
}
