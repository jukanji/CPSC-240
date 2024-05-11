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
;  Date program began: 2024-Apr-14
;  Date of last update: 2024-Apr-14
;  Files in this program: r.sh, executive.asm, fill_random_array.asm, isnan.asm, main.c, normalize_array.asm, 
;                       show_array.asm, sort.cpp
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program asks the user for the number of values they want in an array, randomizes that number of numbers, then
;  inserts it into an array, normalizes each number, and then sorts them.
;
;This file:
;  File name: executive.asm
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
;  Prototype of this function: string executive();
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

extern printf
extern stdin
extern fgets
extern strlen
extern scanf

extern fill_random_array
extern show_array
extern normalize_array
extern sort

global executive

array_size equ 100
name_string_size equ 48
title_string_size equ 48

segment .data
    intro_name db "Please enter your name: ", 10, 0
    intro_title db "Please enter your title (Mr, Ms, Sargent, Chief, Project, Leader, ect): ", 10, 0
    intro_full_name db "Nice to meet you %s %s", 10, 0
    
    instructions_one db "This program will generate 64-bit IEEE float numbers.", 10, 0
    instructions_two db "How many numbers do you want. Today's limit is 100 per customer.", 10 ,0
    instructions_three db "Your numbers have been stored in an array. Here is that array. ", 10, 0
    instructions_four db "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array", 10 ,0
    instructions_five db "The array will now be sorted", 10, 0

    goodbye_message db "Good bye %s. You are welcome any time.", 10, 0

    newline db "", 10, 0

    float_format dq "%lf", 0
    int_format db "%d", 0
    string_format dq "%s", 0


segment .bss
    align 64
    backup_storage_area resb 832
    user_name resb name_string_size
    title resb title_string_size
    an_array resq array_size
    

segment .text

executive:
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

; Output our intro message
    mov rax, 0
    mov rdi, intro_name
    call printf

; Retrieve user's name
    mov rdi, user_name
    mov rsi, name_string_size
    mov rdx, [stdin]
    call fgets

; remove newline
    mov rax, 0
    mov rdi, user_name
    call strlen
    mov [user_name + rax - 1], byte 0

; Output the title message
    mov rdi, intro_title
    call printf

; Receive the user's title
    mov rdi, title
    mov rsi, title_string_size
    mov rdx, [stdin]
    call fgets

; remove newline
    mov rax, 0
    mov rdi, title
    call strlen
    mov [title + rax - 1], byte 0

; Output their full name and title
    mov rdi, intro_full_name
    mov rsi, title
    mov rdx, user_name
    call printf

; Ouput instrucitons line 1
    mov rdi, instructions_one
    call printf

; Output instructions line 2
    mov rdi, instructions_two
    call printf

; Retrieve the number of elements we want in our array from the user
    mov rdi, int_format
    mov rsi, rsp
    call scanf
    mov r15, [rsp]  ;r15 now holds the number of items we want in our array

; Call our input array to add our random values
    mov rdi, an_array
    mov rsi, r15   ;number of items in our array
    call fill_random_array

; Output our first prompt
    mov rax, 0
    mov rdi, instructions_three
    call printf

; Add an empty line for "fanciness"
    mov rdi, newline
    call printf

; Call our output array function
    mov rdi, an_array
    mov rsi, r15
    call show_array

; Call our normalize array function
    mov rdi, an_array
    mov rsi, r15
    call normalize_array

; Output our second prompt
    mov rdi, instructions_four
    call printf

; Add an empty line for "fanciness"
    mov rdi, newline
    call printf

; Show our normalized array
    mov rdi, an_array
    mov rsi, r15
    call show_array

; Output our second prompt
    mov rdi, instructions_five
    call printf

; Add an empty line for "fanciness"
    mov rdi, newline
    call printf

; Call our sort array function to sort our array in c++
    mov rdi, an_array
    mov rsi, r15
    call sort

; Display our now sorted array
    mov rdi, an_array
    mov rsi, r15
    call show_array

; Output our goodbye message to the user
    mov rdi, goodbye_message
    mov rsi, title
    call printf

; Restore xmm registers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

; move our name to rax so we can return it to our main
    mov rax, user_name

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

    ; cd /mnt/c/users/kanji/documents/'assignment 4'