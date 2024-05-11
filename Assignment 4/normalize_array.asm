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
;  Program name: normalize_array
;  Programming languages: x86 Assembly, C, C++
;  Date program began: 2024-Apr-14
;  Date of last update: 2024-Apr-14
;  Files in this program: r.sh, executive.asm, fill_random_array.asm, isnan.asm, main.c, normalize_array.asm, 
;                       show_array.asm, sort.cpp
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program normalizes an array given by the executive file
;
;This file:
;  File name: normalize_array.asm
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
;  Prototype of this function: void normalize_array(double* array, int array_size);
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global normalize_array

segment .data
    output_format dq "0x%016lx %18.13g", 10, 0
    newline db "", 10, 0

segment .bss
    align 64
    backup_storage_area resb 832

segment .text

normalize_array:
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

mov r15, rdi    ;holds our array
mov r14, rsi    ;holds the number of values
mov r13, 0      ;our counter

check_capacity:
    cmp r13, r14
    jl normalize
    jmp exit

normalize:
    movsd xmm15, [r15 + r13 * 8]
    push qword 0
    movsd [rsp], xmm15
    pop r12
    shl r12, 12
    shr r12, 12
    mov rax, 0x3ff0000000000000
    or r12, rax
    
    push r12
    movsd xmm15, [rsp]
    pop r12

    movsd [r15 + r13 * 8], xmm15
    inc r13
    jmp check_capacity

exit:

; Restore xmm registers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]
    
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

    ; /mnt/c/users/kanji/documents/assignment 4