#!/bin/csh
#
if (! -e contacts) then
  mkdir contacts
endif
foreach i ($argv)
  $WDIR/contact $i 5.0 > contacts/$i:t:r".contacts"
end
