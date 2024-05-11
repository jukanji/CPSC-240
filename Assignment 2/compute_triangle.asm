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
;  Program name: Compute Triangle
;  Programming languages: One module in C, two in X86, and one in bash.
;  Date program began: 2024-Feb-20
;  Date of last update: 2024-Feb-24
;  Files in this program: r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program calculates the length of the third side of a triangle given the lenghts of the    
;  other two lengths and the angle in between
;
;This file:
;  File name: compute_triangle.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard):
;       nasm -f elf64 -l compute_triangle.lis -o compute_triangle.o compute_triangle.asm
;       nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm
;  Assemble (debug): 
;       nasm -g dwarf -l compute_triangle.lis -o compute_triangle.o compute_triangle.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double compute_triangle();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

extern printf
extern stdin
extern fgets
extern strlen
extern scanf

extern isfloat
extern atof
extern cos
extern sqrt

global compute_triangle

name_string_size equ 48
title_string_size equ 48
true equ -1
false equ 0

segment .data
    starting_time db "The starting time on the system clock is %lu tics", 10, 0

    prompt_for_name db "Please enter your name: ", 0
    friendly_message db "Please enter you title (Sergent, Chief, CEO, President, Teacher, etc): ", 10, 0
    goodmorning_message db "Good morning %s %s. We take care of all your triangles.", 10, 0

    first_length_input db "Please enter the length of the first side: ", 0
    second_length_input db "Please enter the length of the second side: ", 0
    angle_size_input db "Please enter the size of the angle in degrees: ", 0

    thankyou_message db "Thank you %s. You have entered %lf %lf and %lf.", 10, 0

    third_side_calc db "The length of the third side is %lf", 10, 0

    driver_message db "This length will be sent to the driver program.", 10, 0

    ending_time db "The final time on the system clock is %lu tics.", 10, 0
    goodbye_message db "Have a good day %s %s.", 10, 0

    prompt_error db "Invalid input. Try again: ", 0

    format_float db "%lf", 0
    const_float_two dq 2.0
    const_pi dq 3.1415926535897932
    degree_to_rad dq 180.0

segment .bss
    align 64
    backup_storage_area resb 832
    user_name resb name_string_size
    title resb title_string_size
    

segment .text
compute_triangle:
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

; Read clock start time
    cpuid
    rdtsc
    shl rdx, 32
    add rdx, rax
    mov r12, rdx
; Output the starting time of the clock
    mov rax, 0
    mov rdi, starting_time
    mov rsi, r12
    call printf

; Output the prompts for the username
    mov rax, 0
    mov rdi, prompt_for_name
    call printf

; Retrieve input username
    mov rax, 0
    mov rdi, user_name
    mov rsi, name_string_size
    mov rdx, [stdin]
    call fgets

; Remove newline
    mov rax, 0
    mov rdi, user_name
    call strlen
    mov [user_name + rax - 1], byte 0

; Output the title prompt for user
    mov rax, 0
    mov rdi, friendly_message
    call printf

; Input title for user
    mov rax, 0
    mov rdi, title
    mov rsi, title_string_size
    mov rdx, [stdin]
    call fgets

; Remove newline   
    mov rax, 0
    mov rdi, title
    call strlen
    mov [title + rax - 1], byte 0

; Output Good morning message
    mov rax, 0
    mov rdi, goodmorning_message
    mov rsi, title
    mov rdx, user_name
    call printf

; Output first length prompt
    mov rax, 0
    mov rdi, first_length_input
    call printf

; Start first loop asking for the first length of the triangle
begin_first_loop:
    
; Get the first length user input
    mov rax, 0
    sub rsp, 4096
    mov rdi, rsp
    mov rsi, 4096
    mov rdx, [stdin]
    call fgets
    ;movsd xmm15, [rdx]
; Remove newline character
    mov rax, 0
    mov rdi, rsp
    call strlen
    mov [rsp + rax -1], byte 0

; Check if number inputted is a float
    mov rax, 0
    mov rdi, rsp
    call isfloat
    cmp rax, true
    jne invalid_first_input

; Convert the input into a float value
    mov rax, 0
    mov rdi, rsp
    call atof
    movsd xmm15, xmm0
    jmp exit_first_loop

; Handle error, if it's not a float or a negative number
invalid_first_input:
    add rsp, 4096   ; pop the qword
    mov rax, 0
    mov rdi, prompt_error
    call printf
    jmp begin_first_loop
    
exit_first_loop:
    add rsp, 4096


; Output second length prompt
    mov rax, 0
    mov rdi, second_length_input
    call printf

; Start second loop
begin_second_loop:

; Get the second length of the triangle
    mov rax, 0
    sub rsp, 4096
    mov rdi, rsp
    mov rsi, 4096
    mov rdx, [stdin]
    call fgets
; Remove newline character
    mov rax, 0
    mov rdi, rsp
    call strlen
    mov [rsp + rax - 1], byte 0

; Check if number is a float value
    mov rax, 0
    mov rdi, rsp
    call isfloat
    cmp rax, true
    jne invalid_second_input

; Convert the input into a float value
    mov rax, 0
    mov rdi, rsp
    call atof
    movsd xmm14, xmm0
    jmp exit_second_loop

; Handle error, if it's not a float or a negative number
invalid_second_input:
    add rsp, 4096   ; pop the qword
    mov rax, 0
    mov rdi, prompt_error
    call printf
    jmp begin_second_loop

exit_second_loop:
    add rsp, 4096


; Output the angle size prompt
    mov rax, 0
    mov rdi, angle_size_input
    call printf
; Start third loop
begin_third_loop:

; Get size of angle
    mov rax, 0
    sub rsp, 4096
    mov rdi, rsp
    mov rsi, 4096
    mov rdx, [stdin]
    call fgets
; Remove newline character
    mov rax, 0
    mov rdi, rsp
    call strlen
    mov [rsp + rax - 1], byte 0

; Check if number is a float
    mov rax, 0
    mov rdi, rsp
    call isfloat
    cmp rax, true
    jne invalid_third_input

; Convert the input into a float value
    mov rax, 0
    mov rdi, rsp
    call atof
    movsd xmm13, xmm0
    jmp exit_third_loop

; Handle error, if it's not a float or a negative number
invalid_third_input:
    add rsp, 4096
    mov rax, 0
    mov rdi, prompt_error
    call printf
    jmp begin_third_loop

exit_third_loop:
    add rsp, 4096

; Output thank you message
    mov rax, 3
    mov rdi, thankyou_message
    mov rsi, user_name
    movsd xmm0, xmm15
    movsd xmm1, xmm14
    movsd xmm2, xmm13
    call printf

; Calculate the length of the third side using C = sqrt(a^2 + b^2 - 2ab*cos(t))
    mov rax, 1
    mulsd xmm13, [const_pi]
    divsd xmm13, [degree_to_rad]            ; these two convert my degree value to radians
    movsd xmm0, xmm13
    call cos                                ; use cosine on the angle stored in xmm13
    movsd xmm13, xmm0                       ; save my cos(t) into xmm13
    mulsd xmm13, xmm14                      ; multiply b * (cos(t)) and save into xmm13
    mulsd xmm13, xmm15                      ; multiply a * the answer above amd save into xmm13
    mulsd xmm13, [const_float_two]          ; multiply 2 with the answer above
    mulsd xmm15, xmm15                      ; calculate a^2
    mulsd xmm14, xmm14                      ; calculate b^2
    addsd xmm14, xmm15                      ; add a^2 and b^2
    subsd xmm14, xmm13                      ; finish a^2 + b^2 -2ab*cos(t)
    movsd xmm0, xmm14
    call sqrt
    movsd xmm14, xmm0

    mov rax, 1
    movsd xmm14, xmm0
    mov rdi, third_side_calc
    call printf

; Save the third length data onto the stack
    push qword 0
    push qword 0
    movsd [rsp], xmm14

; Output the driver message
    mov rax, 1
    movsd xmm0, xmm14
    mov rdi, driver_message
    call printf

; Output the end time message
    cpuid
    rdtsc
    shl rdx, 32
    add rdx, rax
    mov r12, rdx
; Retrieve the ending time
    mov rax, 0
    mov rdi, ending_time
    mov rsi, r12
    call printf

; Output goodbye message
    mov rax, 0
    mov rdi, goodbye_message
    mov rsi, title
    mov rdx, user_name
    call printf

; Restore all floating point numbers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

; Retrieve the third length data and return it to the driver
    movsd xmm0, [rsp]
    pop rax
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