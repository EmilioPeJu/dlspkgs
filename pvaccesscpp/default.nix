{ epicsRepoBaseUrl, buildEpicsModule, pvcommoncpp, pvdatacpp
}:

buildEpicsModule rec {
  name = "pvaccesscpp";
  buildInputs = [ pvcommoncpp pvdatacpp ];
  src = builtins.fetchGit {
    url = "${epicsRepoBaseUrl}/pvaccesscpp";
    ref = "dls-master";
  };
  postInstall = ''
    cd $out/bin
    for i in linux-x86_64/*; do
        ln -s "$i"
    done
  '';
}
