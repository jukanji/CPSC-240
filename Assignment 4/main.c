//Author: Kanji Oyama
//Author email: kanjioyama@csu.fullerton.edu
//Program name: Randomized Arrays
//Programming languages: x86 Assembly, C, C++
//Date program began: 2024-Apr-14
//Date of last update: 2024-Apr-14
//Files in this program: r.sh, executive.asm, fill_random_array.asm, isnan.asm, main.c, normalize_array.asm, 
//                       show_array.asm, sort.cpp
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program takes in user value of how many random numbers they want in an array and then takes in that number of 
//  random numbers into an array, normalizes them, then sorts them.
//This file
//  File name: main.c
//  Language: C
//  Max page width: 124 columns
//  #compile
//      gcc -m64 -Wall -no-pie -o main.o -std=c2x -c main.c
//      g++ -c -m64 -Wall -fno-pie -no-pie -o sort.o sort.cpp -std=c++17
//  #link
//      gcc -m64 -no-pie -o assignment4.out main.o executive.o fill_random_array.o isnan.o show_array.o normalize_array.o 
//      sort.o -std=c2x -Wall -z noexecstack -lm

#include <stdio.h>

extern char* executive();

int main()
{
    printf("Welcome to to Random Products, LLC.\n");
    printf("This software is maintained by Kanji Oyama\n");

    char* result = executive();

    printf("Oh, %s. We hope you enjoyed your arrays. Do come again.\n", result);
    printf("A zero will be returned to the operating system.\n");

    return 0;
}