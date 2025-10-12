; a guessing game
; system generates a number, user gueses the number
; the system gives a response

section .data
  sys_write equ 1
  sys_read  equ 0
  stdout    equ 1
  stdin     equ 0
  sys_exit  equ 60

  ans             equ 4
  correct_str     db  "correct!", 0x0a, 0x0
  correct_str_len equ $ - correct_str
  wrong_str       db  "wrong!\n", 0x0           ; does this work?
  wrong_str_len   equ $ - wrong_str
  prompt_str      db  "guess the number: ", 0x0
  prompt_str_len  equ $ - prompt_str

section .bss
  guess     resb 256
  guess_len resb 1

section .text
  global _start

; code logic
; print: guess the number
; receive user input
; check if number is correct
; output response
; exit
_start:
  mov rax, sys_write
  mov rdi, stdout
  mov rsi, prompt_str
  mov rdx, prompt_str_len
  syscall


  mov rax,                    sys_read
  mov rdi,                    stdin
  mov rsi,                    guess
  mov rdx,                    255
  syscall
  mov byte [guess + rax - 1], 0
  mov qword [guess_len],      rax - 1

  ; parse input and convert from ascii string (sys_read returns ascii string) to number
  ; Convert the ASCII character to its numerical value; done by subtracting null-terminator '0'
  ; since that is the start of ascii
  ; use rdx as a temp variable to hold the parsed number
  xor rdx, rdx
  mov rcx, qword [guess_len]
.parse_input:
  movzx rbx,           byte [guess]
  sub   rbx,           '0'
  add   rdx,           rbx
  dec   rcx
  loop  .parse_input
  mov   qword [guess], rdx          ; useless move?

  ; compare the converted number
  cmp rdx, qword [ans]
  je  .correct

.wrong:
  mov rax, sys_write
  mov rdi, stdout
  mov rsi, wrong_str
  mov rdx, wrong_str_len
  syscall
  jmp .exit

.correct:
  mov rax, sys_write
  mov rdi, stdout
  mov rsi, correct_str
  mov rdx, correct_str_len
  syscall

.exit:
  mov rax, sys_exit
  mov rdi, 0
  syscall
