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
;  Program name: Producer
;  Programming languages: x86 Assembly, C++
;  Date program began: 2024-Apr-09
;  Date of last update: 2024-Apr-09
;  Files in this program: r.sh, producer.asm, sin.asm, ftoa.cpp, director.cpp
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program takes in two side lengths and an angle length to calculate the area of our triangle
;
;This file:
;  File name: producer.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard):
;       nasm -f elf64 -l producer.lis -o producer.o producer.asm
;       nasm -f elf64 -l sin.lis -o sin.o sin.asm
;       
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: string executive();
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global producer

extern atof
extern sin
extern ftoa

segment .data
    length_one db "Please enter the length of side 1: ", 0
    length_two db "Please enter the length of side 2: ", 0
    angle_input db "Please enter the degrees of the angle between: ", 0
    
    area_output_one db "The area of this triangle is ", 0
    area_output_two db " square feet", 10, 0

    thankyou_message db "Thank you for using Kanji product.", 10, 0

    PI dq 3.141592653589793238462643383279502884197
    num_two dq 2.0
    radian dq 180.0

    STDOUT equ 1
    SYS_write equ 1

    STDIN equ 0
    SYS_read equ 0

segment .bss
    align 64
    backup_storage_area resb 832

    float_input resb 20

    area_total resq 20

segment .text

producer:
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

; Print out our first side message
    mov rax, STDOUT
    mov rdi, SYS_write
    mov rsi, length_one
    mov rdx, 36
    syscall

; Get input for side length 1
    mov rax, STDIN
    mov rdi, SYS_read
    mov rsi, float_input
    mov rdx, 20
    syscall

; Call atof
    mov rax, 0
    mov rdi, float_input
    call atof

    movsd xmm15, xmm0       ;saves side length 1 in xmm15

    ;mov rax, 60
    ;xor rdi, rdi
    ;syscall

; Print out our second side message
    mov rax, STDOUT
    mov rdi, SYS_write
    mov rsi, length_two
    mov rdx, 36
    syscall

; Get input for side length 2
    mov rax, STDIN
    mov rdi, SYS_read
    mov rsi, float_input
    mov rdx, 20
    syscall

; Call atof
    mov rax, 0
    mov rdi, float_input
    call atof

    movsd xmm14, xmm0       ;saves side length 2 in xmm14

; Print out our angle message
    mov rax, STDOUT
    mov rdi, SYS_write
    mov rsi, angle_input
    mov rdx, 47
    syscall

; Get input for our angle length
    mov rax, STDIN
    mov rdi, SYS_read
    mov rsi, float_input
    mov rdx, 20
    syscall

; Call atof
    mov rax, 0
    mov rdi, float_input
    call atof
    movsd xmm13, xmm0       ;saves angle length in xmm13

    mulsd xmm13, [PI]       ;convert to radians
    divsd xmm13, [radian]

; Calculate the area using (1/2) ab x sin(C)
    mov rax, 1
    movsd xmm0, xmm13
    call sin
    movsd xmm13, xmm0

    mulsd xmm15, xmm14
    divsd xmm15, [num_two]
    mulsd xmm15, xmm13

; Print out our area message
    mov rax, STDOUT
    mov rdi, SYS_write
    mov rsi, area_output_one
    mov rdx, 30
    syscall

; Convert our area into a string using ftoa
    mov rax, 1
    movsd xmm0, xmm15
    mov rdi, area_total
    mov rsi, 20
    call ftoa
    
; Output our area
    mov rax, STDOUT
    mov rdi, SYS_write
    mov rsi, area_total
    mov rdx, 30
    syscall

; Print out the rest of our area message
    mov rax, STDOUT
    mov rdi, SYS_write
    mov rsi, area_output_two
    mov rdx, 14
    syscall

; Output our thank you message before terminating
    mov rax, STDOUT
    mov rdi, SYS_write
    mov rsi, thankyou_message
    mov rdx, 36
    syscall

; Move our return onto the stack to not get erased
    push qword 0
    movsd [rsp], xmm15

; Restore xmm registers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

; move our name to rax so we can return it to our main
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

    ; cd /mnt/c/users/kanji/documents/'assignment 5'