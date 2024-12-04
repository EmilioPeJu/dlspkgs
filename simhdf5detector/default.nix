{ epicsRepoBaseUrl, buildEpicsModule, asyn, adcore, hdf5 }:

buildEpicsModule {
  name = "simHDF5Detector";
  buildInputs = [ asyn adcore hdf5 ];
  src = builtins.fetchGit { url = "${epicsRepoBaseUrl}/simhdf5detector"; };
  patches = [ ./builder-to-py3.patch ./fix-missing-include.patch ];
}
