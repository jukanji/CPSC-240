//Author: Kanji Oyama
//Author email: kanjioyama@csu.fullerton.edu
//Program name: Area of a Triangle
//Programming languages: x86 Assembly, C++
//Date program began: 2024-Apr-09
//Date of last update: 2024-Apr-09
//Files in this program: r.sh, producer.asm, sin.asm, ftoa.cpp, director.cpp
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program takes in two side lengths and an angle length to calculate the area of our triangle
//This file
//  File name: director.cpp
//  Language: C++
//  Max page width: 124 columns
//  #compile
//      gcc -m64 -Wall -no-pie -o director.o -std=c2x -c director.c
//  #link
//      g++ -m64 -no-pie -o assignment5.out director.o producer.o sin.o ftoa.o -std=c2x -Wall -z noexecstack -lm

#include <stdio.h>

extern "C" double producer();

int main()
{
    printf("Welcome to Marvelous Kanji's Area Machine.\n");
    printf("We compute all your areas.\n");

    double result = producer();

    printf("The driver received this number %lf and will keep it.\n", result);
    printf("A zero will be sent to the OS as a sign of successful conclusion.\n");
    printf("Bye\n");

    return 0;
}