//Author: Kanji Oyama
//Author email: kanjioyama@csu.fullerton.edu
//Program name: Sort
//Programming languages: x86 Assembly, C, C++
//Date program began: 2024-Apr-14
//Date of last update: 2024-Apr-14
//Files in this program: r.sh, executive.asm, fill_random_array.asm, isnan.asm, main.c, normalize_array.asm, 
//                       show_array.asm, sort.cpp
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program takes in an array and sorts it.
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
#include <math.h>

using namespace std;

extern "C" void sort(double array[], int array_size);

/**
 * define function compute_variance with:
 * @param double array[]: the array that contains the numbers inserted by the user
 * @param int array_size: the number of elements contained in the array
 * @return a double of the computed variance using the formula for variance
 * */ 

void sort(double array[], int array_size)
{
    double temp;
    for (int i = 0; i < array_size; ++i)
    {
        for (int j = 0; j < array_size - i - 1; ++j)
        {
            if (array[j] > array[j + 1])
            {
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}