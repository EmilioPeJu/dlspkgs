{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-pvcommoncpp, dls-epics-pvdatacpp
}:

buildEpicsModule rec {
  name = "dls-epics-normativetypescpp";
  buildInputs = [ dls-epics-pvcommoncpp dls-epics-pvdatacpp ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/normativetypescpp";
    ref = "dls-master";
  };
}
