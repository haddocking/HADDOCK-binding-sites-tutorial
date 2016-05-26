#!/bin/csh
#
if ($#argv != 2) goto usage

set scale=`head -1 $1 |awk '{print $1/100}'`
foreach i (` awk '{print $2"."$1"."$3}' $1`)
  set b=`echo $i |sed -e 's/\./\ /g' |awk -v scale=$scale '{if ($2/scale < 1) {print 1.0} else {print $2/scale}}'`
  set r=`echo $i |sed -e 's/\./\ /g' |awk '{print $1}'`
  set ch=`echo $i |sed -e 's/\./\ /g' |awk '{print $3}'`
  $WDIR/zone_b -$b -z$ch$r,$ch$r $2 >pdb.tmp
  \mv pdb.tmp $2
end

goto exit

usage:
echo "Usage: encode-contacts.csh <contact-stats-file> <pdb-file>"
echo ""
echo "   The PDB file should contain chainIDs matching the ones in the contact stats file"
echo "   The contact stats file should contain contacts statistics in the following format:"
echo "      6 700 A"
echo "      6 693 A"
echo "      ...."
echo "   where the first number is the occurence, the second the residue number and the third the chainID"
echo ""
echo "   The B-factor field of the input PDB file will be modified according to the contact frequency in a scale from 1 to 100"

exit:
