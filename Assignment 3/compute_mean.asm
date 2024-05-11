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
;  Program name: compute_mean
;  Programming languages: x86 Assembly
;  Date program began: 2024-Mar-8
;  Date of last update: 2024-Mar-15
;  Files in this program: compute_mean
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program calculates the mean of all values inputted by the user in the array    
;
;This file:
;  File name: compute_mean.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard):
;       nasm -f elf64 -l compute_mean.lis -o compute_mean.o compute_mean.asm
;
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double compute_mean(double array[], int array_size)
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global compute_mean

extern printf

segment .data
    first_array db "This is the first element in the array %lf", 10 ,0
segment .bss
    align 64
    backup_storage_area resb 832


segment .text

compute_mean:

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

; Move the parameters to a safe place 
    mov r15, rdi    ; holds the array
    mov r14, rsi    ; holds the number of elements in the array
    mov r13, 0

; Expecting one float value
;    mov rax, 1

; Start the loop to add all the elements together
loop_start:
    cmp r13, r14
    je exit
    addsd xmm15, [r15 + r13 * 8]
    inc r13
    jmp loop_start

exit:
    mov rax, 1
    mov rdi, first_array
    cvtsi2sd xmm14, rsi     ; convert our number of elements into a float
    divsd xmm15, xmm14

; Push answer onto stack to retrieve it
    push qword 0
    movsd [rsp], xmm15

; Restore all floating point numbers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

; we want our mean value to return to the manager
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