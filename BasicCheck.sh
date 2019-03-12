#!/bin/bash
folderName=$1
executeble=$2

cd $folderName

make

secssesfullMake=$?

if [ $secssesfullMake -eq 0 ]; then 

Comp="passed"
co=0

    valgrind --tool=memcheck ${@:3} --leak-check=full --error-exitcode=1 -q ./$execute &> /dev/null

if [ $? -eq 0 ]; then
Memcheck="passed"
mem=0

else
Memcheck="failed"
mem=1
fi



valgrind --tool=helgrind --error-exitcode=1 -q ./$executeble &> /dev/null

secssesfulhel=$?

if [ $? -eq 0 ]; then
Trcheck="passed"
tr=0
else
Trcheck="failed"
tr=1
fi

else
Comp="failed"
co=1
exit 7

fi

echo " compilation   memory leak  thread race"
echo "  $Comp          $Memcheck    $Trcheck "

output=$co$mem$tr

if [$output == '000']; then 
exit 0
fi

if [$output == '001']; then 
exit 1
fi
if [$output == '010']; then 
exit 2
fi
if [$output == '011']; then 
exit 3
fi




