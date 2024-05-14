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
//  File name: ftoa.cpp
//  Language: C++
//  Max page width: 124 columns
//  #compile
//      g++ -c -m64 -Wall -fno-pie -no-pie -o ftoa.o ftoa.cpp -std=c++17
//  #link
//      g++ -m64 -no-pie -o assignment5.out director.o producer.o sin.o ftoa.o -std=c2x -Wall -z noexecstack -lm


#include <stdio.h>
#include <iostream>
#include <string>

extern "C" void ftoa(double num, char *arr, int size);

void ftoa(double num, char *arr, int size) 
{
  // Convert the float to a string
  std::string str = std::to_string(num);

  // Copy the string into the provided array
  // Ensure the string does not exceed the array size
  int copySize = std::min(static_cast<std::string::size_type>(str.size()),
                          static_cast<std::string::size_type>(size - 1));
  std::copy(str.begin(), str.begin() + copySize, arr);

  // Null-terminate the array
  arr[copySize] = '\0';
}