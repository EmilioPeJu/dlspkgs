from iocbuilder import AutoSubstitution, Device
from iocbuilder.modules.devlib2 import Devlib2
from iocbuilder.arginfo import *

class mrfioc2(Device):
    Dependencies = (Devlib2,)
    LibFileList = ["evgmrm", "evrMrm", "mrmShared", "evr", "mrfCommon"]
    DbdFileList = ["mrf"]
    
    def __init__(self, evrname, slot="5:0.0"):
        self.__super.__init__()
        self.evrname = evrname
        self.slot = slot

    def InitialiseOnce(self):
        print '# /sbin/lspci identifies the bus number of device 1204:ec30 (1a3e:172c)'
        print '# 5:0.0, 0, 0 should be correct if the EVR is installed in the standard slot'
        print 'mrmEvrSetupPCI("%s", "%s", 0, 0)' % (self.evrname, self.slot)

    ArgInfo = makeArgInfo(__init__,
        evrname = Simple('EVR name', str),
        slot = Simple('PCIe slot (e.g. 5:0.0 for slot 5 - check lspci output)', str))


class defaultPCIe(AutoSubstitution):
    Dependencies = (mrfioc2,)
    """Default Template for the PCIe MRM-EVR-300 and IFB-300"""
    TemplateFile="defaultPCIe.template"


class evrMTCA300(AutoSubstitution):
    Dependencies = (mrfioc2,)
    TemplateFile="evr-mtca-300.db"
