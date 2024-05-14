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
;  Program name: Sin
;  Programming languages: x86 Assembly, C++
;  Date program began: 2024-Apr-09
;  Date of last update: 2024-Apr-09
;  Files in this program: r.sh, producer.asm, sin.asm, ftoa.cpp, director.cpp
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program calculates sin from an angle input from the user. The program uses Taylor Series caluculation to
;  estimate the value of sin.
;
;This file:
;  File name: sin.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard):
;       nasm -f elf64 -l producer.lis -o producer.o producer.asm
;       nasm -f elf64 -l sin.lis -o sin.o sin.asm
;       
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: string executive();
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global sin

array_size equ 100
name_string_size equ 48
title_string_size equ 48

segment .data
    float_format dq "%lf", 0
    int_format db "%d", 0
    string_format dq "%s", 0


segment .bss
    align 64
    backup_storage_area resb 832
    

segment .text

sin:
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

    movsd xmm9, xmm0         ;move our angle to xmm9
    movsd xmm8, xmm9
    mov r14, 0               ;loop counter
    mov r13, 0               ;initial term

    cvtsi2sd xmm10, r13

; Start loop
check_capacity:
    cmp r14, 20
    jl taylor_series
    jmp exit

; Taylor series loop Start
taylor_series:
    addsd xmm10, xmm8       ;xmm10 hold our total

    mov rbx, r14
    movsd xmm13, xmm9       ;xmm13 is x

    mulsd xmm13, xmm13      ;xmm13 = x^2
    mov r8, -1
    cvtsi2sd xmm11, r8
    mulsd xmm13, xmm11

    imul rbx, 2
    add rbx, 2
    mov rcx, rbx
    inc rcx
    imul rbx, rcx
    cvtsi2sd xmm14, rbx

    divsd xmm13, xmm14
    
    mulsd xmm8, xmm13

    inc r14
    jmp check_capacity

exit:

; Push answer onto stack to not have it get erased
    push qword 0
    movsd [rsp], xmm10

; Restore xmm registers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

; Retrieve answer on the stack
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