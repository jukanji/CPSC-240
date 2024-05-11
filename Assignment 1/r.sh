#/bin/bash

#Program name "Average"
#Author: K. Oyama
#This file is the script file that accompanies the "Average" program.
#Prepare for execution in normal mode (not gdb mode).

rm *.o
rm *.out

#assemble
nasm -f elf64 -l average.lis -o average.o average.asm

#compile
gcc -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c

#link
gcc -m64 -no-pie -o assignment1.out driver.o average.o -std=c2x -Wall -z noexecstack

#execute
./assignment1.out

echo "This bash script will now terminate."
