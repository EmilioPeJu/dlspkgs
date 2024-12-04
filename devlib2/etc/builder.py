from iocbuilder import Device

#print "Hello from %s" % __file__

class Devlib2(Device):
    "class to represent devlib2 dependency"
    # TODO: basedon arch select vme or pci includes
    LibFileList = [ "epicspci", "epicsvme"]
    DbdFileList = [ "epicspci"]
    AutoInstantiate = True

