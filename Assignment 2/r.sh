#/bin/bash

#Program name "compute_triangle"
#Author: K. Oyama
#This file is the script file that accompanies the "Compute Triangle" program.
#Prepare for execution in normal mode (not gdb mode).

rm *.o
rm *.out

#assemble
nasm -f elf64 -l compute_triangle.lis -o compute_triangle.o compute_triangle.asm

nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

#compile
gcc -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c
nasm -f elf64 -o isfloat.o isfloat.asm

#link
gcc -m64 -no-pie -o assignment2.out driver.o compute_triangle.o isfloat.o -std=c2x -Wall -z noexecstack -lm

#execute
./assignment2.out

echo "This bash script will now terminate."
