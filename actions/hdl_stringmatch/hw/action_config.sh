#!/bin/bash
############################################################################
############################################################################
##
## Copyright 2017 International Business Machines
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE#2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions AND
## limitations under the License.
##
############################################################################
############################################################################

if [ -L verilog ]; then
    unlink verilog
fi

if [ -L ../fpga_ip ]; then
    unlink ../fpga_ip
fi

#if [ -L ../sw/utils ]; then
#    unlink ../sw/utils
#fi
STRING_MATCH_VERILOG=../string-match-fpga/verilog

if [ -z $STRING_MATCH_VERILOG ]; then
  echo "WARNING!!! Please set STRING_MATCH_VERILOG to the path of string match verilog"
else
  ln -s $STRING_MATCH_VERILOG verilog
  cd ..
  ln -s ./hw/$STRING_MATCH_VERILOG/../fpga_ip ./fpga_ip
  cd ./hw
#  ln -s $STRING_MATCH_VERILOG/../utils ../sw/utils
fi

if [ ! -d $STRING_MATCH_VERILOG/../fpga_ip/managed_ip_project ]; then
    $STRING_MATCH_VERILOG/../fpga_ip/all_ip_gen.pl -ieslibs $IES_LIBS -fpga_chip $FPGACHIP -outdir $STRING_MATCH_VERILOG/../fpga_ip
else
    echo "IP already exit, no need to regenerate"
fi
