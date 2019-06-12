#!/bin/csh
#
set found=`which wget |grep -v found |wc -l`
  if ($found == 0) then
    set found=`which curl |grep -v found |wc -l`
    if ($found == 0) then
      echo 'No curl nor wget found in your system'
      echo 'Unable to download expample data'
      goto exit
    else
      set cmd=`which curl`
      $cmd -L https://surfdrive.surf.nl/files/index.php/s/po5DUg5sUNdMqC7/download >AcrB-rifampicin-surface-h24.tgz
      $cmd -L https://surfdrive.surf.nl/files/index.php/s/9DeYWJBRdLtOT0a/download >AcrB-rifampicin-pocket-h24.tgz
    endif
  else
    set cmd=`which wget`
    $cmd https://surfdrive.surf.nl/files/index.php/s/po5DUg5sUNdMqC7/download -O AcrB-rifampicin-surface-h24.tgz
    $cmd https://surfdrive.surf.nl/files/index.php/s/9DeYWJBRdLtOT0a/download -O AcrB-rifampicin-pocket-h24.tgz
  endif
endif

exit:
