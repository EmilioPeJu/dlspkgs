{ buildPythonPackage, dls-epics-base, epicscorelibs }:

buildPythonPackage rec {
  pname = "epicsdbbuilder";
  version = "1.4";
  src = builtins.fetchGit {
    url = "https://github.com/dls-controls/epicsdbbuilder";
  };
  buildInputs = [ dls-epics-base ];
  propagatedBuildInputs = [ epicscorelibs ];
}
