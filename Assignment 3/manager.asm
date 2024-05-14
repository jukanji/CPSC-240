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
;  Program name: Manager
;  Programming languages: x86 Assembly, C, C++
;  Date program began: 2024-Mar-8
;  Date of last update: 2024-Mar-15
;  Files in this program: r.sh, manager.asm, input_array.asm, compute_mean.asm, compute_variance.cpp, isfloat.asm, output_array.c
;                           main.c
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program takes in user float value input and places them into an array, calculates the mean and variance of the array, and
;  then returns the variance.
;
;This file:
;  File name: manager.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard):
;       nasm -f elf64 -l manager.lis -o manager.o manager.asm
;       nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
;       nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm
;       nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm 
;       
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double manager();
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

extern printf
extern input_array
extern compute_mean
extern output_array
extern compute_variance

global manager

array_size equ 12

segment .data
    intro_line_one db "This program will manage your arrays of 64-bit floats", 10, 0
    intro_line_two db "For the array enter a sequence of 64-bit floats separated by white space", 10, 0
    intro_line_three db "After the last input press enter followed by Control+D:", 10, 0
    empty_line db " ", 10, 0
    outro_line_one db "These numbers were received and placed into an array", 10, 0
    average_output db "The mean of the numbers in the array is %lf", 10 ,0
    outro_line_two db "The variance of the inputted number is %lf", 10, 0

segment .bss
    align 64
    backup_storage_area resb 832
    an_array resq array_size
    

segment .text

manager:
; Backup GPR's
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

; Backup registers
    mov rax, 7
    mov rdx, 0
    xsave [backup_storage_area]

; Output the line informing the user that this program will manage 64-bit floats
    mov rax, 0
    mov rdi, intro_line_one
    call printf
; Output the name of who it was brought to you by (Kanji Oyama)
    mov rdi, intro_line_two
    call printf
; Output the line informing the user to press ctrl+D after their last input
    mov rdi, intro_line_three
    call printf

; Call input_array to input the user's values into the array
    mov rdi, an_array
    mov rsi, array_size
    call input_array
    mov r13, rax

; Print an empty line for visual aesthetic
    mov rdi, empty_line
    call printf

; Output the line letting the user know that their values are placed into the array
    mov rdi, outro_line_one
    call printf

; Call our C function output_array to display our array for the user
    mov rax, 0
    mov rdi, an_array
    mov rsi, r13
    call output_array

; Call the compute_mean function to calculate the mean of our array values
    mov rax, 0
    mov rdi, an_array
    mov rsi, r13
    call compute_mean
    movsd xmm15, xmm0
; Output the mean of the numbers for the user to see
    mov rax, 1
    mov rdi, average_output
    movsd xmm0, xmm15
    call printf
    movsd xmm15, xmm0

; Call compute_variance to compute the variance of the values in our c++ function
    mov rax, 0
    mov rdi, an_array
    mov rsi, r13
    call compute_variance
    movsd xmm15, xmm0
; Output the line letting our user know what the variance of your values are
    mov rax, 1
    mov rdi, outro_line_two
    movsd xmm0, xmm15
    call printf

; Print an empty line for aesthetic purposes
    mov rdi, empty_line
    call printf

; Push our output onto the stack so it doesn't get erased
    push qword 0
    movsd [rsp], xmm15

; Restore xmm registers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

; Retrieve our return value from rsp
    movsd xmm0, [rsp]
    pop rax
    
; Restore the GPR's
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp   ;Restore rbp to the base of the activation record of the caller program
    ret