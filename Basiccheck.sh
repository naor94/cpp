#!/bin/bash
folderName=$1
executeble=$2




cd $folderName

if [ -f Makefile ] ; then


make

secssesfullMake=$?

if [$secssesfullMake -eq 0];then

Comp="passed"
co=4
valgrind --leak-check=full --error-exitcode=1 ./$executeble &> output.txt 
secssesfulval=$?
valgrind--tool=helgrind --error-exitcode=1 ./$executeble &> output.txt
secssesfulhel=$?

if [$secssesfulval -eq 0]; then
Memcheck="passed"
mem=2

else
Memcheck="failed"
mem=0
fi

if [$secssesfulhel -eq 0]; then
Trcheck="passed"
tr=1
else
Trcheck="failed"
tr=0
fi

else
Comp="failed"
co=0

fi




echo " compilation   memory leak  thread race"
echo "  $Comp          $Memcheck    $Trcheck "


output=$co+$mem+$tr
exit $output

else
echo "No makefile"
fi

