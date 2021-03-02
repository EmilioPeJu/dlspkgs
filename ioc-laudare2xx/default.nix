{ buildBuilderIoc, dls-epics-asyn, dls-epics-streamdevice, dls-epics-busy
, dls-epics-laudare2xx, config }:

buildBuilderIoc rec {
  name = "ioc-laudare2xx";

  buildInputs = [
    dls-epics-asyn
    dls-epics-streamdevice
    dls-epics-busy
    dls-epics-laudare2xx
  ];

  iocXml = builtins.toFile "iocXml" ''
    <?xml version="1.0" ?>
    <components arch="linux-x86_64">
      <asyn.AsynIP name="laudaPort1" port="${config.ipAddr}"/>
      <laudaRE2xx.lRE2xx ADDR="0" HIGH="180" HIHI="200" LOLO="-20" LOW="-15" P="${config.pvPrefix}" PORT="laudaPort1" SCAN="5" name="LAUDA"/>
      <asyn.auto_asynRecord ADDR="0" IMAX="1024" OMAX="1024" P="${name}" PORT="laudaPort1" R=":ASYN1" name="${name}.Asyn1"/>
    </components>
  '';
}
