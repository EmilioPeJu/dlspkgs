from __future__ import print_function
import os.path

from iocbuilder import Device, SetSimulation
from iocbuilder.support import quote_c_string
from iocbuilder.arginfo import *

# These devices are used directly, while the others are loaded as part of
# other devices
__all__ = ['Asyn', 'AsynSerial', 'AsynIP']


class Asyn(Device):
    LibFileList = ['asyn']
    DbdFileList = ['asyn']
    AutoInstantiate = True
    

class AsynPort(Device):
    Dependencies = (Asyn,)

    # Set of allocated ports to avoid accidential duplication.
    __Ports = set()

    # Flag used to identify this as an asyn device.
    IsAsyn = True

    def __init__(self, name):
        self.asyn_name = name
        assert name not in self.__Ports, \
            'AsynPort %s already defined' % name
        self.__Ports.add(name)
        self.__super.__init__()
                
    def DeviceName(self):
        return self.asyn_name

    def __str__(self):
        return self.DeviceName()


class _AsynOctetInterface(AsynPort):

    ValidSetOptionKeys = set([
        'baud', 'bits', 'parity', 'stop', 'crtscts'])

    def __init__(self, port,
            name=None, input_eos=None, output_eos=None,
            priority=100, noAutoConnect=False, noProcessEos=False,
            simulation=None, **options):
        self.port_name = port
        assert set(options.keys()) <= self.ValidSetOptionKeys, \
            'Invalid argument to asynSetOption'
        self.options = options
        self.input_eos = input_eos
        self.output_eos = output_eos
        self.priority = priority
        self.noAutoConnect = int(noAutoConnect)
        self.noProcessEos = int(noProcessEos)
        self.__super.__init__(name)    
               
    def Initialise(self):
        print('%sConfigure("%s", "%s", %d, %d, %d)' % (
            self.DbdFileList[0], self.asyn_name, self.port_name, self.priority,
            self.noAutoConnect, self.noProcessEos))
        for key, value in self.options.items():
            print('asynSetOption("%s", 0, "%s", "%s")' % (
                self.asyn_name, key, value))
        if self.input_eos is not None:
            print('asynOctetSetInputEos("%s", 0, %s)' % (
                self.asyn_name, quote_c_string(self.input_eos)))
        if self.output_eos is not None:
            print('asynOctetSetOutputEos("%s", 0, %s)' % (
                self.asyn_name, quote_c_string(self.output_eos)))

    # __init__ attributes
    ArgInfo = makeArgInfo(__init__, ValidSetOptionKeys,
        port          = Simple('Serial port tty name / IP address optionally followed by protocol', str),
        name          = Simple('Override name', str),
        input_eos     = Simple('Input end of string (terminator)', str),
        output_eos    = Simple('Output end of string (terminator)', str),
        priority      = Simple('Priority', int),
        noAutoConnect = Simple('Set to stop autoconnect', bool),
        noProcessEos  = Simple('Set to avoid processing end of string', bool),
        simulation    = Simple('IP port to connect to if in simulation mode', str),
        # SetOption keys        
        baud          = Simple('Baud Rate', int),
        bits          = Choice('Bits', [8,7,6,5]), 
        parity        = Choice('Parity', ['none','even','odd']),
        stop          = Choice('Stop Bits', [1,2]),
        crtscts       = Choice('Set hardware flow control on', ['N','Y']))

class AsynSerial(_AsynOctetInterface):
    '''Asyn Serial Port'''

    DbdFileList = ['drvAsynSerialPort']

    # just pass the port name to AsynOctet interface
    def __init__(self, port, name = None, **kwargs):
        if name is None:
            name = port[1:].replace('/', '_')
        self.__super.__init__(port, name, **kwargs)
   
class AsynIP(_AsynOctetInterface):
    '''Asyn IP Port'''

    DbdFileList = ['drvAsynIPPort']  
    
    # validate the port then pass it up
    def __init__(self, port, name = None, **kwargs):
        IsIpAddr(port)
        if name is None:
            name = port.replace(".", "_").replace(":","_")
        self.__super.__init__(port, name, **kwargs)       

class Vxi11(_AsynOctetInterface):
    '''Asyn vxi11 Port'''

    DbdFileList = ['drvVxi11']

    def __init__(self, port,
            name=None, flags=0, timeout="0.0", vxiName="gpib0", **kwargs):
        IsIpAddr(port)
        if name is None:
            name = port.replace(".", "_").replace(":","_")            
        self.flags = flags
        self.timeout = timeout
        self.vxiName = vxiName        
        self.__super.__init__(port, name, **kwargs)    
               
    def Initialise(self):
        print('vxi11Configure("%s", "%s", %d, %s, "%s", %d, %d)' % (
            self.asyn_name, self.port_name, self.flags, self.timeout,
            self.vxiName, self.priority, self.noAutoConnect))

    # __init__ attributes
    ArgInfo = makeArgInfo(__init__,
        port          = Simple('IP address', str),
        name          = Simple('Asyn Port name', str),
        flags         = Simple('flags (lock devices : recover with IFC)', int),        
        timeout       = Simple('default timeout', float),
        vxiName       = Simple('vxi name'),
        priority      = Simple('Priority', int),
        noAutoConnect = Simple('Set to stop autoconnect', bool),
        simulation    = Simple('IP port to connect to if in simulation mode', str))

def IsIpAddr(val):
    # validator for an ip address
    errStr = "'%s' should be of format x[xx].x[xx].x[xx].x[xx][:x[x..]] [protocol]" % val
    # split into ip and port
    split = val.strip().split(" ")[0].split(":")
    # check we have either just an ip, or an ip and a port
    assert len(split)in [1,2], errStr
    # check the port is in an int if it exists
    if len(split) == 2:
        assert split[1].isdigit(), errStr

def AsynSerial_sim(port, simulation=None, AsynIP=AsynIP, **args):
    if simulation:
        return AsynIP(simulation, **args)

SetSimulation(AsynSerial, AsynSerial_sim)

def AsynIP_sim(port, simulation=None, AsynIP=AsynIP, **args):
    if simulation:
        return AsynIP(simulation, **args)
        
SetSimulation(AsynIP, AsynIP_sim)

def Vxi11_sim(port, simulation=None, Vxi11=Vxi11, **args):
    if simulation:
        return Vxi11(simulation, **args)
        
SetSimulation(Vxi11, Vxi11_sim)
