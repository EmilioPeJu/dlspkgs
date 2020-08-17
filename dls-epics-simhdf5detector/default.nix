{ epicsRepoBaseUrl, buildEpicsModule, dls-epics-asyn, dls-epics-adcore, hdf5 }:

buildEpicsModule {
  name = "dls-epics-simHDF5Detector";
  buildInputs = [ dls-epics-asyn dls-epics-adcore hdf5 ];
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/simhdf5detector"; };
  patches = [ ./builder-to-py3.patch ];
}
