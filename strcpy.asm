bits 64

section .data
  source db "Copy me!", 0 ; The string to be copied

section .bss
  destination resb 100 ; Reserve 100 bytes for the copy

section .text
  global _start

_start:
  ; Register Setup:
  mov rsi, source      ; RSI = Source pointer (Current read position)
  mov rdi, destination ; RDI = Destination pointer (Current write position)

.loop_copy:
  ; --- 1. Load Byte from Source ---
  mov al, byte [rsi] ; Load 1 byte into AL from the address pointed to by RSI

  ; --- 2. Check for Null Terminator ---
  cmp al, 0     ; Is the byte we just read 0?
  je  .loop_end ; If it is the end, exit the loop

  ; --- 3. Store Byte to Destination ---
  mov byte [rdi], al ; Write the byte in AL to the address pointed to by RDI

  ; --- 4. Increment Pointers ---
  inc rsi ; Move source pointer to the next byte
  inc rdi ; Move destination pointer to the next byte

  jmp .loop_copy ; Unconditional jump back to the start of the loop

.loop_end:
  mov byte [rdi], 0 ; Write the null byte (0) to the current RDI position

  ; Exit syscall (60)
  mov rax, 60
  mov rdi, 0
  syscall
