{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-asyn, dls-epics-adcore, hdf5 }:

buildEpicsModule {
  name = "dls-epics-simhdf5detector";
  buildInputs = [ dls-epics-asyn dls-epics-adcore hdf5 ];
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/simhdf5detector"; };
}
