#/bin/bash

#Program name "compute_triangle"
#Author: K. Oyama
#This file is the script file that accompanies the "Compute Triangle" program.
#Prepare for execution in normal mode (not gdb mode).

rm *.o
rm *.out

#assemble
nasm -f elf64 -l executive.lis -o executive.o executive.asm
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm
nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm
nasm -f elf64 -l normalize_array.lis -o normalize_array.o normalize_array.asm

#compile
gcc -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
g++ -c -m64 -Wall -fno-pie -no-pie -o sort.o sort.cpp -std=c++17

#link
gcc -m64 -no-pie -o assignment4.out main.o executive.o fill_random_array.o isnan.o show_array.o normalize_array.o sort.o -std=c2x -Wall -z noexecstack -lm

#execute
./assignment4.out

echo "This bash script will now terminate."
