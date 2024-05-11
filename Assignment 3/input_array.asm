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
;  Program name: input_array
;  Programming languages: x86 Assembly
;  Date program began: 2024-Mar-8
;  Date of last update: 2024-Mar-15
;  Files in this program: input_array
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program calculates inputs the values given by the user into an array  
;
;This file:
;  File name: input_array
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard):
;       nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
;
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double input_array(double array[], int array_size)
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

extern printf

extern input_array

extern scanf

extern printf

extern isfloat

extern atof

segment .data
    format_string db "%s"
    tryagain_prompt db "The last input was invalid and not entered into the array.", 10, 0

segment .bss
    align 64
    backup_storage_area resb 832

segment .text

input_array:
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

; Save the passed parameters to a safe place and initialize our counter r15
    mov r15, rdi    ; r15 holds our array
    mov r14, rsi    ; r14 max array size
    mov r13, 0      ; r13 contains our counter
    sub rsp, 1024

fill_array:
    mov rax, 0
    mov rdi, format_string
    mov rsi, rsp
    call scanf

    ; Check for ctrl+D input
    cdqe
    cmp rax, -1
    je exit

    ; Check if input is a valid number
    mov rax, 0
    mov rdi, rsp
    call isfloat
    cmp rax, 0
    je error

    ; Convert the input into a float
    mov rax, 0
    mov rdi, rsp
    call atof

    ; Copy the float into our array
    movsd [r15 + r13 * 8], xmm0

    ; Increment our counter and compare with our capacity
    inc r13
    cmp r13, r14
    jl fill_array

    ; Jump to exit if we are full
    jmp exit

error:
    mov rax, 0
    mov rdi, tryagain_prompt
    call printf
    jmp fill_array

exit:
    add rsp, 1024

; Restore all floating point numbers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

; Move our value to rax
    mov rax, r13    ; outputs the current number of elements in the array

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