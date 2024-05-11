//****************************************************************************************************************************
//Program name: "Begin Assembly".  This program serves as a model for new programmers of X86 programming language.  This     *
//shows the standard layout of a function written in X86 assembly.  The program is a live example of how to complie,         *
//assembly, link, and execute a program containing source code written in X86.  Copyright (C) 2024  Floyd Holliday.          *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************

//Author: Kanji Oyama
//Author email: kanjioyama@csu.fullerton.edu
//Program name: Average
//Programming languages: One module in C, one in X86, and one in bash.
//Date program began: 2024-Jan-24
//Date of last update: 2024-Feb-4
//Files in this program: average.c, average.asm, r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program is a starting point for those learning to program in x86 assembly

//This file
//  File name: average.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -no-pie -o average.o -std=c20 -Wall driver.c -c
//  Link: gcc -m64 -no-pie -o assignment1.out driver.o average.o -std=c2x -Wall -z noexecstack

#include <stdio.h>

extern double average();

int main()
{
    printf("Welcome to average maintained by Kanji Oyama\n");
    double count = 0;
    count = average();
    printf("The driver has received this number %lf and will keep it for future use.\n", count);
    printf("Have a great day.\n");
    printf("\n");
    printf("A zero will be sent to the operating system as a signal of a successful execution.");

    return -1;
}