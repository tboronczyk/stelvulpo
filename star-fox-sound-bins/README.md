# Star Fox Sound Binary Disassemblies
This repository contains disassemblies of all sound binaries used in Star Fox, except for the sound driver (SGSOUND0).  
For a disassembly of SGSOUND0, see [Phonymike's disassembly](https://github.com/phonymike/starfox_spc_driver).  

## Assembly
Either run ``build.bat``, or run ``make`` on the command line.  
You can edit the makefile to specify which BINs to build, rather than all of them by changing ``$(BUILD_FILES)`` in the ``BUILD ?=`` option to the names of the BINs you wish to assemble.  
Assembled output will appear in the ``build`` directory.  