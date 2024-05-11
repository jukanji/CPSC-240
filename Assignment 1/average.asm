;****************************************************************************************************************************
;Program name: "Average". This program calculates the average speed from Fullerton to Santa Ana, Santa Ana to Long Beach,   *
;and then Long Bach to Fullerton.                                                                                   *
;                                                                                                                           *
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
;  Program name: Average
;  Programming languages: One module in C, one in X86, and one in bash.
;  Date program began: 2024-Jan-24
;  Date of last update: 2024-Feb-4
;  Files in this program: driver.c, average.asm, r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program calculates the average speed from Fullerton to Santa Ana, Santa Ana to Long Beach,   
;  and then Long Bach to Fullerton.
;
;This file:
;  File name: average.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l average.lis -o average.o average.asm
;  Assemble (debug): nasm -g dwarf -l average.lis -o average.o average.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: double average();
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

global average

name_string_size equ 48
title_string_size equ 48

segment .data
    prompt_for_name db "Please enter your first and last names: ", 0
    friendly_message db "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc: ", 10, 0
    thankyou_message db "Thank you %s %s", 10, 0
    first_miles_input db "Enter the number of miles traveled from Fullerton to Santa Ana: ", 0
    second_miles_input db "Enter the number of miles traveled from Santa Ana to Long Beach: ", 0
    third_miles_input db"Enter the number of miles traveled from Long Beach to Fullerton: ", 0
    speed_input_prompt db "Enter your average speed during that leg of the trip: ", 0
    processing_text db "The inputted data are being processed.", 0
    total_distance db "The total distance traveled is %lf miles.", 10, 0
    total_time db "The time of the trip is %lf hours", 10, 0
    average_speed db "The average speed during this trip is %lf mph.", 10, 0

    format_float db "%lf", 0
    const_float_three dq 3.0

segment .bss
    align 64
    backup_storage_area resb 832
    user_name resb name_string_size
    title resb title_string_size

segment .text
average:
;Backup GPRs
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

;Backup registers
    mov rax, 7
    mov rdx, 0
    xsave [backup_storage_area]
    
;Output the prompts for user
    mov rax, 0
    mov rdi, prompt_for_name
    call printf

;Input usernames
    mov rax, 0
    mov rdi, user_name
    mov rsi, name_string_size
    mov rdx, [stdin]
    call fgets

;Remove newline
    mov rax, 0
    mov rdi, user_name
    call strlen
    mov [user_name + rax - 1], byte 0

;Output the title prompt for user
    mov rax, 0
    mov rdi, friendly_message
    call printf

;Input title for user
    mov rax, 0
    mov rdi, title
    mov rsi, title_string_size
    mov rdx, [stdin]
    call fgets

;Remove newline
    mov rax, 0
    mov rdi, title
    call strlen
    mov [title + rax - 1], byte 0

;Send thank you message
    mov rax, 0
    mov rdi, thankyou_message
    mov rsi, title
    mov rdx, user_name
    call printf

;Output first distance prompt
    mov rax, 0
    mov rdi, first_miles_input
    call printf
;Get first distance
    mov rax, 0
    push qword 0
    push qword 0
    mov rdi, format_float
    mov rsi, rsp
    call scanf
    movsd xmm15, [rsp] ;xmm15 contains the distance from Fullerton to Santa Ana
    pop rax
    pop rax
;Output first speed prompt
    mov rax, 0
    mov rdi, speed_input_prompt
    call printf
;Get first speed
    mov rax, 0
    push qword 0
    push qword 0
    mov rdi, format_float
    mov rsi, rsp
    call scanf
    movsd xmm14, [rsp] ;xmm14 contains the average speed from Fullerton to Santa Ana
    pop rax
    pop rax

;Output second distance prompt
    mov rax, 0
    mov rdi, second_miles_input
    call printf
;Get second distance
    mov rax, 0
    push qword 0
    push qword 0
    mov rdi, format_float
    mov rsi, rsp
    call scanf
    movsd xmm13, [rsp] ;xmm13 contains the distance from Santa Ana to Long Beach
    pop rax
    pop rax
;Output second speed prompt
    mov rax, 0
    mov rdi, speed_input_prompt
    call printf
;Get second speed
    mov rax, 0
    push qword 0
    push qword 0
    mov rdi, format_float
    mov rsi, rsp
    call scanf
    movsd xmm12, [rsp] ;xmm12 contains the average speed from Santa Ana to Long Beach
    pop rax
    pop rax

;Output third distance prompt
    mov rax, 0
    mov rdi, third_miles_input
    call printf
;Get third distance
    mov rax, 0
    push qword 0
    push qword 0
    mov rdi, format_float
    mov rsi, rsp
    call scanf
    movsd xmm11, [rsp] ;xmm11 contains the distance from Long Beach to Fullerton
    pop rax
    pop rax
;Get third speed prompt
    mov rax, 0
    mov rdi, speed_input_prompt
    call printf
;Get third speed
    mov rax, 0
    push qword 0
    push qword 0
    mov rdi, format_float
    mov rsi, rsp
    call scanf
    movsd xmm10, [rsp] ;xmm10 contains the average speed from Long Beach to Fullerton
    pop rax
    pop rax

;Output the total distance
    movsd xmm1, xmm11
    movsd xmm2, xmm13
    addsd xmm2, xmm15
    addsd xmm1, xmm2
    push qword 0
    push qword 0
    mov rax, 1
    mov rdi, total_distance
    mov rsi, format_float
    movsd xmm0, xmm1
    call printf
    pop rax
    pop rax

;Output the time of the trip
    divsd xmm15, xmm14
    divsd xmm13, xmm12
    divsd xmm11, xmm10
    addsd xmm13, xmm11
    addsd xmm15, xmm13
    push qword 0
    push qword 0
    mov rax, 1
    mov rdi, total_time
    mov rsi, format_float
    movsd xmm0, xmm15
    call printf
    pop rax
    pop rax

;Output average speed
    addsd xmm12, xmm10
    addsd xmm14, xmm12
    divsd xmm14, qword[const_float_three]
    push qword 0
    push qword 0
    mov rax, 1
    mov rdi, average_speed
    mov rsi, format_float
    movsd xmm0, xmm14
    call printf
    pop rax
    pop rax

    push qword 0
    movsd [rsp], xmm14

;Restore registers
    mov rax, 7
    mov rdx, 0
    xrstor [backup_storage_area]

    movsd xmm0, [rsp]
    pop rax

;Restore the GPRs
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