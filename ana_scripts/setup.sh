#!/bin/bash
#

export  target=complex
export WDIR=`pwd`
export refe=$WDIR/3AOD-renumbered-RFP.pdb

if [ -f zone_b ]; then
    rm zone_b
fi

if [ $(uname) == "Linux" ] || [ $(uname) == "linux" ]; then
  ln -s zone_b.linux zone_b
fi

if [ $(uname) == "Darwin" ]; then
  ln -s zone_b.macosx zone_b
fi
