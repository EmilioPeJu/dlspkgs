{ buildBuilderIoc, dls-epics-asyn, dls-epics-streamdevice
, dls-epics-watsonmarlow, ipAddr, pvPrefix }:

buildBuilderIoc rec {
  name = "ioc-watsonmarlow";

  buildInputs =
    [ dls-epics-asyn dls-epics-streamdevice dls-epics-watsonmarlow ];

  iocXml = builtins.toFile "iocXml" ''
    <?xml version="1.0" ?>
    <components arch="linux-x86_64">
      <asyn.AsynIP name="watsonmarlowPort1" port="${ipAddr}"/>
      <watson-marlow.Pump323Du P="${pvPrefix}" PORT="watsonmarlowPort1" Q="" name="PPUMP"/>
      <asyn.auto_asynRecord ADDR="0" IMAX="1024" OMAX="1024" P="${name}" PORT="watsonmarlowPort1" R=":ASYN1" name="${name}.Asyn1"/>
    </components>
  '';
}
