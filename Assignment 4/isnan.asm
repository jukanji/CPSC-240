;****************************************************************************************************************************
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Kanji Oyama
;  Author email: kanjioyama@csu.fullerton.edu
;
;Program information
;  Program name: isnan
;  Programming languages: x86 Assembly, C, C++
;  Date program began: 2024-Apr-14
;  Date of last update: 2024-Apr-14
;  Files in this program: r.sh, executive.asm, fill_random_array.asm, isnan.asm, main.c, normalize_array.asm, 
;                       show_array.asm, sort.cpp
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program tells the user whether or not a certain element is a number or not.
;
;This file:
;  File name: isnan.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard):
;       nasm -f elf64 -l executive.lis -o executive.o executive.asm
;       nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm
;       nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm
;       nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm
;       nasm -f elf64 -l normalize_array.lis -o normalize_array.o normalize_array.asm 
;       
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: bool isnan(double value);
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


global isnan

segment .data        ;Place initialized data here

segment .bss         ;Declare pointers to un-initialized space in this segment.

segment .text
isnan:               ;Entry point.  Execution begins here.

;=========== Back up all the GPRs whether used in this program or not =========================================================

  push       rbp                                              ;Save a copy of the stack base pointer
  mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
  push       rbx                                              ;Back up rbx
  push       rcx                                              ;Back up rcx
  push       rdx                                              ;Back up rdx
  push       rsi                                              ;Back up rsi
  push       rdi                                              ;Back up rdi
  push       r8                                               ;Back up r8
  push       r9                                               ;Back up r9
  push       r10                                              ;Back up r10
  push       r11                                              ;Back up r11
  push       r12                                              ;Back up r12
  push       r13                                              ;Back up r13
  push       r14                                              ;Back up r14
  push       r15                                              ;Back up r15
  pushf                                                       ;Back up rflags

;move our number to a r register
  movsd xmm15, xmm0


  ucomisd xmm15, xmm15
  jp nan
  mov rax, 1
  jmp exit

nan:
  mov rax, 0  ;this is a nan

exit:
;Restore the original values to the GPRs
  popf                                                        ;Restore rflags
  pop        r15                                              ;Restore r15
  pop        r14                                              ;Restore r14
  pop        r13                                              ;Restore r13
  pop        r12                                              ;Restore r12
  pop        r11                                              ;Restore r11
  pop        r10                                              ;Restore r10
  pop        r9                                               ;Restore r9
  pop        r8                                               ;Restore r8
  pop        rdi                                              ;Restore rdi
  pop        rsi                                              ;Restore rsi
  pop        rdx                                              ;Restore rdx
  pop        rcx                                              ;Restore rcx
  pop        rbx                                              ;Restore rbx
  pop        rbp                                              ;Restore rbp

  ret                                                         ;No parameter with this instruction.  This instruction will pop 8 bytes from
                                                            ;the integer stack, and jump to the address found on the stack.
;========== End of program fp-io.asm ======================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
