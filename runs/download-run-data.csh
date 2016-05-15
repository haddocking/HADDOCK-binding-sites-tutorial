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
      $cmd -L https://surfdrive.surf.nl/files/index.php/s/6ajivh236do43t6/download >AcrB-rifampicin-surface.tgz
      $cmd -L https://surfdrive.surf.nl/files/index.php/s/jRQ5cTq9NWz6RiM/download >AcrB-rifampicin-pocket.tgz
    endif
  else
    set cmd=`which wget`
    $cmd https://surfdrive.surf.nl/files/index.php/s/6ajivh236do43t6/download -O AcrB-rifampicin-surface.tgz
    $cmd https://surfdrive.surf.nl/files/index.php/s/jRQ5cTq9NWz6RiM/download -O AcrB-rifampicin-pocket.tgz
  endif
endif

exit:
