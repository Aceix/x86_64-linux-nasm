; a simple programe to simulate Z = (X + Y) x 5

section .data
  result dq 0
  myvar dq 5 ; to understand

section .text
global _start
_start:
  ; need to see the diff btn these
_chkpt1:
  mov rax, myvar
  mov rax, [myvar]

  mov rax, 10
  mov rcx, 20
  add rax, rcx
  imul rax, rax, 5
_chkpt2:
  mov [result], rax
  ; (syntax error) does not work because you need to dereference the memory address to store the value
  ; "result" alone is a memory address [ ] is the dereference operator
  ; mov result, rax

  ; exit the app
  mov rax, 60
  mov rdi, 0
  syscall
