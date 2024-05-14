//Author: Kanji Oyama
//Author email: kanjioyama@csu.fullerton.edu
//Program name: compute_variance
//Programming languages: C++
//Date program began: 2024-Mar-8
//Date of last update: 2024-Mar-15
//Files in this program: compute_mean.asm
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program takes in user float value input and places them into an array, calculates the mean and variance of the
//  array, and then returns the variance.
//This file
//  File name: compute_variance.cpp
//  Language: C
//  Max page width: 124 columns
//  Compile:
//      g++ -c -m64 -Wall -fno-pie -no-pie -o compute_variance.o compute_variance.cpp -std=c++17
//  Link:
//      gcc -m64 -no-pie -o assignment3.out main.o manager.o input_array.o isfloat.o compute_mean.o output_array.o
//      compute_variance.o -std=c2x -Wall -z noexecstack -lm
//      

#include <stdio.h>
#include <math.h>

using namespace std;

extern "C" double compute_variance(double array[], int array_size);

/**
 * define function compute_variance with:
 * @param double array[]: the array that contains the numbers inserted by the user
 * @param int array_size: the number of elements contained in the array
 * @return a double of the computed variance using the formula for variance
 * */ 

double compute_variance(double array[], int array_size)
{
    // declare my variables to insert the average and variance
    double average = 0.0;
    double variance = 0.0;

    // this loop is to calculate the average to use in my variance formula
    for (int i = 0; i < array_size; ++i)
    {
        average+= array[i];
    }
    average /= array_size;

    // I created a sum of squares variable to help with finding my variance
    double sum_of_squares = 0.0;

    // this loop is to iterate through each element in the array and finding the square of (the element - the average)
    for (int i = 0; i < array_size; ++i)
    {
        sum_of_squares += pow(array[i] - average, 2);
    }
    variance = sum_of_squares / (array_size - 1);

    // return our variance double that we calculated back to the manager file
    return variance;
}