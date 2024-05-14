#/bin/bash

#Program name "Arrays"
#Author: K. Oyama
#This file is the script file that accompanies the "Arrays" program.
#Prepare for execution in normal mode (not gdb mode).

rm *.o
rm *.out

#assemble
nasm -f elf64 -l manager.lis -o manager.o manager.asm
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm
nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm

#compile
gcc -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
nasm -f elf64 -o input_array.o input_array.asm
nasm -f elf64 -o isfloat.o isfloat.asm
nasm -f elf64 -o compute_mean.o compute_mean.asm
gcc -m64 -Wall -no-pie -o output_array.o -std=c2x -c output_array.c
g++ -c -m64 -Wall -fno-pie -no-pie -o compute_variance.o compute_variance.cpp -std=c++17

#link
gcc -m64 -no-pie -o assignment3.out main.o manager.o input_array.o isfloat.o compute_mean.o output_array.o compute_variance.o -std=c2x -Wall -z noexecstack -lm

#execute
./assignment3.out

echo "This bash script will now terminate."
