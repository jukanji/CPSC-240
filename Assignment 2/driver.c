//Author: Kanji Oyama
//Author email: kanjioyama@csu.fullerton.edu
//Program name: Compute Triangle
//Programming languages: One module in C, two in X86, and one in bash.
//Date program began: 2024-Feb-20
//Date of last update: 2024-Feb-24
//Files in this program: driver.c, compute_triangle.asm, r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program is a starting point for those learning to program in x86 assembly

//This file
//  File name: average.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile:
//      gcc -m64 -Wall -no-pie -o driver.o -std=c2x -c driver.c
//      nasm -f elf64 -o isfloat.o isfloat.asm
//  Link:
//      gcc -m64 -no-pie -o assignment2.out driver.o compute_triangle.o isfloat.o -std=c2x -Wall -z noexecstack -lm

#include <stdio.h>
#include <math.h>

extern double compute_triangle();

int main()
{
    printf("Welcome to Amazing Triangles programmed by Kanji Oyama on February 24, 2024\n");
    double count = 0;
    count = compute_triangle();
    printf("The driver has received this number %lf and will simply keep it.\n", count);
    printf("An integer zero will now be sent to the operating system. Bye\n");
    return -1;
}