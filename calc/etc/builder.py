from iocbuilder import Device

__all__ = ['Calc']

class Calc(Device):
    LibFileList = ['calc']
    DbdFileList = ['calcSupport']
    AutoInstantiate = True
