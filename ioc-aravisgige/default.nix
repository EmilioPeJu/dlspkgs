{ buildBuilderIoc, dls-epics-adcore, dls-epics-aravisgige, dls-epics-adutil
, ipAddr, pvPrefix, cameraClass ? "AVT_Mako_1_52" }:

buildBuilderIoc rec {
  name = "ioc-aravisgige";
  buildInputs = [ dls-epics-adcore dls-epics-aravisgige dls-epics-adutil ];
  iocXml = builtins.toFile "iocXml" ''
    <?xml version="1.0" ?>
    <components arch="linux-x86_64">
        <EPICS_BASE.EpicsEnvSet key="EPICS_CA_MAX_ARRAY_BYTES" value="9000000"/>
        <aravisGigE.aravisCamera ADDR="0" CLASS="${cameraClass}" ID="${ipAddr}" P="${pvPrefix}" PORT="ARV.CAM" R=":CAM:" TIMEOUT="1"/>
        <adUtil.gdaPlugins CAM="ARV.CAM" NELEMENTS="12288000" P="${pvPrefix}" PORTPREFIX="PIPE"/>
        <ADCore.NDTransform ADDR="0" NDARRAY_PORT="ARV.CAM" P="${pvPrefix}" PORT="PIPE.trans" R=":TRANS:" TIMEOUT="1"/>
    </components>
      '';
}
