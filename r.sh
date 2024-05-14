#/bin/bash

#Program name 
#Author: K. Oyama
#This file is the script file that accompanies the " " program.
#Prepare for execution in normal mode (not gdb mode).

rm *.o
rm *.out

#assemble
nasm -f elf64 -l producer.lis -o producer.o producer.asm

nasm -f elf64 -l sin.lis -o sin.o sin.asm

#compile
#gcc -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
g++ -c -m64 -Wall -fno-pie -no-pie -o director.o director.cpp -std=c++17

g++ -c -m64 -Wall -fno-pie -no-pie -o ftoa.o ftoa.cpp -std=c++17

#link
g++ -m64 -no-pie -o assignment5.out director.o producer.o sin.o ftoa.o -std=c2x -Wall -z noexecstack -lm

#execute
./assignment5.out

echo "This bash script will now terminate."
