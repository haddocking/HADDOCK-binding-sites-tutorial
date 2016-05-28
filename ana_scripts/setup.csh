#!/bin/csh
#
setenv target complex
setenv WDIR `pwd`
setenv refe $WDIR/3AOD-renumbered-RFP.pdb

if ( -k zone_b ) then
  \rm zone_b
endif

if (`uname` == Darwin) then
  ln -s zone_b.macosx zone_b
endif

if (`uname` == Linux || `uname` == linux) then
  ln -s zone_b.linux zone_b
endif

