#!/bin/bash
# This script patch COMCOT so it can generate arrival time data by itself.
# The program will record the arrival time with the highest level of time resolution (use origin time-step)
# , which eliminate the 'shading' effect generated by post-processing method
# because of the lack of time resolution, for each layer.
#<><><><><><><><><><><><><><><><><><><><><><><><><><>
# The update has been sucessfully tested and run on these COMCOT version
# Version: 1.7, 
function backup_files () {
    FILE=$1
    if [ -f $FILE ]; then
        cp $FILE $FILE.bak
    else
        echo "ERROR, $FILE does not exist"
        exit 1
    fi
}


echo "Checking and backuping files"
backup_files comcot.f90
backup_files type_module.f90
backup_files output.f90


echo "Ready, patching files"
patch < comcot.patch
patch < type_mod.patch
patch < output.patch
#mv Makefile Makefile.bak
#mv Makefile.new Makefile

echo "Success, please append 'arrivaltime.f90' to the compiling list in your Makefile"
echo ", or directly use the Makefile provided here if you're using 'ifort'."
