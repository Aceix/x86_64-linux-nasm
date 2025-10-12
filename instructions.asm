bits    64

section .data

section .bss
  padding resq 20

section .text
global  _start

_start:
  ;;; basic movements

  mov rax, 5            ; rax = 0x0000000000000005
  mov al,  10           ; al = 0x0A, rax = 0x000000000000000A
  mov ah,  20           ; ah = 0x14, rax = 0x000000000000140A
  mov ax,  900          ; rax = 0x0000000035A4E900
  mov eax, 0xAB0533FD   ; rax = 0x00000000AB0533FD
  mov rax, 0xAB0533FD00 ; rax = 0x000000AB0533FD00
  mov eax, 0xAB0533FD   ; rax = 0x00000000AB0533FD - upper 32bits are cleared for a 32bit operation

; invalid label. hyphens are not allowed, labels cannot start with a number
; .my-lebel:
; 1he:


;;; unsigned expansions
.unsigned_extensions:
  ; invalid instruction. movzx does not work with immediates
  ; movzx eax, 3
  ; movzx byte [padding], 3
  
  ; doesnt work because of the sizes
  ; movzx rax, qword [padding] ;-- same size
  ; movzx rax, dword [padding] ;-- does not work with 32bits. use `mov` since that will fill the upper 32bits with zeros
  ; movzx byte [padding], rax ;-- cannot movzx into memory. only register. also, smaller dest size
  
  ; cannot movzx into memory. only registers are allowed
  ; movzx dword [padding], ax

  movzx rax, byte [padding] ; zeros out rax because when the OS reserves space for "padding", it initialises to zero
  mov   bl,  3              ; prepare register
  movzx rax, bl             ; move and extend upper bits with zero


;;; signed expansions
.signed_extensions:
  mov   bl,  20  ; prepare register
  mov   cl,  -20 ; prepare register
  movsx rax, bl  ; move and extend upper bits with MSb of bl's value, ie: 20
  movsx rax, cl  ; move and extend upper bits with MSb of cl's value, ie: -20
  


; program crashes on SIGSEGV
