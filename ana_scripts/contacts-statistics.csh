#!/bin/csh
#
cat /dev/null >Acontacts
cat /dev/null >Bcontacts

foreach i ($argv)
  awk '{if (NF==7){print $1,$2}}' contacts/$i:r.contacts |sort |uniq >>Acontacts
  awk '{if (NF==7){print $4,$5}}' contacts/$i:r.contacts |sort |uniq >>Bcontacts
end
sort Acontacts |uniq -c |sort -r -n >Acontacts.lis
sort Bcontacts |uniq -c |sort -r -n >Bcontacts.lis
