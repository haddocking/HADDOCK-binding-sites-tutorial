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
      $cmd -L https://surfdrive.surf.nl/files/index.php/s/68xl6yE0vCpVyqY/download >AcrB-rifampicin-surface.tgz
      $cmd -L https://surfdrive.surf.nl/files/index.php/s/EWXcGT5RVmiP7VZ/download >AcrB-rifampicin-pocket.tgz
    endif
  else
    set cmd=`which wget`
    $cmd https://surfdrive.surf.nl/files/index.php/s/68xl6yE0vCpVyqY/download -O AcrB-rifampicin-surface.tgz
    $cmd https://surfdrive.surf.nl/files/index.php/s/EWXcGT5RVmiP7VZ/download -O AcrB-rifampicin-pocket.tgz
  endif
endif

exit:
