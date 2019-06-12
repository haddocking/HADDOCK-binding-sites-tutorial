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
      $cmd -L https://surfdrive.surf.nl/files/index.php/s/jxxJd5BlHJcX20Z/download > AcrB-rifampicin-surface-full-h24.tgz
      $cmd -L https://surfdrive.surf.nl/files/index.php/s/VhmUsRCLcC5dUjZ/download > AcrB-rifampicin-pocket-full-h24.tgz
    endif
  else
    set cmd=`which wget`
    $cmd https://surfdrive.surf.nl/files/index.php/s/jxxJd5BlHJcX20Z/download -O AcrB-rifampicin-surface-full-h24.tgz
    $cmd https://surfdrive.surf.nl/files/index.php/s/VhmUsRCLcC5dUjZ/download -O AcrB-rifampicin-pocket-full-h24.tgz
  endif
endif

exit:
