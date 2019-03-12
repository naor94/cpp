#!/bin/bash
folderName=$1
executeble=$2

cd $folderName

make

secssesfullMake=$?

if [ $secssesfullMake -eq 0 ]; then 

Comp="passed"
co=0

valgrind --leak-check=full --error-exitcode=1 ./$executeble &> /dev/null
if [ $? -eq 0 ]; then
Memcheck="passed"
mem=0

else
Memcheck="failed"
mem=1
fi



valgrind --tool=helgrind --error-exitcode=1 -q ./$executeble &> /dev/null

secssesfulhel=$?

if [ $? -eq 0 ]; then#!/bin/bash

folderName=$1
execute=$2
cd $folderName
make 

if [ $? -gt 0 ]; then
   Compil=1
else
    Compil=0

valgrind --tool=helgrind --error-exitcode=1 -q ./$execute &> /dev/null
    if [ $? -gt 0 ]; then 
       TreadTemp=1
    else
       TreadTemp=0
    fi 

    valgrind --tool=memcheck ${@:3} --leak-check=full --error-exitcode=1 -q ./$execute &> /dev/null
    if [ $? -gt 0 ]; then
       MemoLa=1
    else
       MemoLa=0
    fi
  
fi
exittemp=$Compil$MemoLa$TreadTemp
if [ $exittemp == '000' ]; then
    echo "Compilation ok "
    echo "Memory leaks ok "
    echo "Thread ok"
    exit 0
elif [ $exittemp == '001' ]; then
      echo "Compilation ok "
      echo "Memory leaks ok "
      echo "Thread FAIL"
      exit 1
elif [ $exittemp == '010' ]; then
      echo "Compilation ok "
      echo "Memory leaks FAIL "
      echo "Thread ok  "
      exit 2
elif [ $exittemp == '011' ]; then 
      echo "Compilation ok "
      echo "Memory leaks FAIL "
      echo "Thread Fail"
      exit 3
else 
      echo "Compilation FAIL "
      echo "Memory leaks FAIL "
      echo "Thread FAIL "
      exit 7
fi
© 2019 GitHub, Inc.
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




