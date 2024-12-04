#!/bin/env dls-python2.7

# setup the path
from pkg_resources import require
require("iocbuilder")
import sys
#sys.path.append("/dls_sw/work/common/python/iocbuilder")

# import modules
import iocbuilder
from dls_dependency_tree import dependency_tree

# parse the options supplied to the program
options, args = iocbuilder.ParseEtcArgs(architecture="linux-x86_64")
# parse configure/RELEASE and configure iocbuilder
iocbuilder.ParseAndConfigure(options, dependency_tree)

# import the builder objects
from iocbuilder.modules import *
from iocbuilder import ModuleVersion
from iocbuilder import hardware, records

# make some objects
ctr = records.scalcout('xxx:userStringCalc2')

# write the IOC
iocbuilder.WriteNamedIoc(options.iocpath, options.iocname, substitute_boot=True)
