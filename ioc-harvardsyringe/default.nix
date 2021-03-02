{ buildBuilderIoc, dls-epics-asyn, dls-epics-streamdevice
, dls-epics-harvardsyringe, config }:

buildBuilderIoc rec {
  name = "ioc-harvardsyringe";
  buildInputs =
    [ dls-epics-asyn dls-epics-streamdevice dls-epics-harvardsyringe ];
  iocXml = builtins.toFile "iocXml" ''
    <?xml version="1.0" ?>
    <components arch="linux-x86_64">
      <asyn.AsynIP name="syringePort1" port="${config.ipAddr}"/>
      <harvardSyringe.harvardSyringe P="${config.pvPrefix}" PORT="syringePort1" Q="" name="SPUMP"/>
      <asyn.auto_asynRecord ADDR="0" IMAX="1024" OMAX="1024" P="${name}" PORT="syringePort1" R=":ASYN1" name="${name}.Asyn1"/>
    </components>
  '';
}
