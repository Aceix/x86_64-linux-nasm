section .data
  mystr db "hello, world", 0
  outstr db "length: ", 0
  outstr_len equ $ - outstr

section .bss
  mystr_len resb 1

section .text
  global _start
_start:
  ; rsi will hold the current pointer to the string
  ; rcx will hold the length of the string
  xor rcx, rcx
  mov rsi, mystr

loop_start:
  mov al, byte [rsi]
  cmp al, 0
  je loop_end
  inc rsi
  inc rcx
  jmp loop_start

loop_end:
  ; save info
  mov [mystr_len], rcx

  ; print string length
  mov rax, 1
  mov rdi, 1
  mov rsi, outstr
  mov rdx, outstr_len
  syscall
  mov rsi, mystr_len
  mov rdx, 0xFF
  syscall

  ; exit
  mov rax, 60
  mov rdi, 0
  syscall
