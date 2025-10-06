; simple program that prints hello world
section .data:
  msg db "hello world", 0xA
  msg_len equ $ - msg

section .text
global _start
_start:
  mov rax, 1 ; 1 is for sys_write according to Linux System V x64 ABI
  mov rdi, 1 ; 1 is the file descriptor for stdout
  mov rsi, msg ; pointer to the message to write
  mov rdx, msg_len ; length of the message
  syscall

  ; exit the app
  mov rax, 60 ; 60 is for sys_exit
  mov rdi, 0 ; exit code 0
  syscall
