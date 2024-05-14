//Author: Kanji Oyama
//Author email: kanjioyama@csu.fullerton.edu
//Program name: Arrays
//Programming languages: x86 Assembly, C, C++
//Date program began: 2024-Mar-8
//Date of last update: 2024-Mar-15
//Files in this program: r.sh, manager.asm, input_array.asm, compute_mean.asm, compute_variance.cpp, isfloat.asm, 
//                       output_array.c, main.c
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program takes in user float value input and places them into an array, calculates the mean and variance of the
//  array, and then returns the variance.
//This file
//  File name: main.c
//  Language: C
//  Max page width: 124 columns
//  Compile:
//      gcc -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
//  Link:
//      gcc -m64 -no-pie -o assignment3.out main.o manager.o input_array.o isfloat.o compute_mean.o output_array.o 
//      compute_variance.o -std=c2x -Wall -z noexecstack -lm

#include <stdio.h>

extern double manager();

int main()
{
    printf("Welcome to Arrays of floating point numbers.\n");
    printf("Bought to you by Kanji Oyama\n");
    printf("\n");
    double result = 0;
    result = manager();
    printf("Main received %lf, and will keep it for future use.\n", result);
    printf("Main will return 0 to the operating system. Bye.\n");

    return 0;
}