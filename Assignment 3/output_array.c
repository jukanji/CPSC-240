//Author: Kanji Oyama
//Author email: kanjioyama@csu.fullerton.edu
//Program name: output_array
//Programming languages: x86 Assembly, C, C++
//Date program began: 2024-Mar-8
//Date of last update: 2024-Mar-15
//Files in this program: r.sh, manager.asm, input_array.asm, compute_mean.asm, compute_variance.cpp, isfloat.asm, 
//                       output_array.c, main.c
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program takes in user float value input and places them into an array and then outputs them for the user
//  to view
//This file
//  File name: output_array.c
//  Language: C
//  Max page width: 124 columns
//  Compile:
//      gcc -m64 -Wall -no-pie -o output_array.o -std=c2x -c output_array.c
//  Link:
//      gcc -m64 -no-pie -o assignment3.out main.o manager.o input_array.o isfloat.o compute_mean.o output_array.o 
//      compute_variance.o -std=c2x -Wall -z noexecstack -lm

/**
 * define function output_array with:
 * @param double array[]: the array that contains the numbers inserted by the user
 * @param int array_size: the number of elements contained in the array
 * @return no return value required
 * */ 
#include <stdio.h>

extern void output_array(double array[], int array_size);

//Prints the contents of the array, up to arr_size, determined by the fill asm module
void output_array(double array[], int array_size) {
  for (int i = 0; i < array_size; i++)
  {
    printf("%.10lf ", array[i]);
  }
  printf("\n");
}