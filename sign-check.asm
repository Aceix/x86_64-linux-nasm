bits 64

section .data
  ; Our output strings
  msg_pos  db  "Positive!", 0xA
  len_pos  equ $ - msg_pos
  msg_neg  db  "Negative!", 0xA
  len_neg  equ $ - msg_neg
  msg_zero db  "Zero!", 0xA
  len_zero equ $ - msg_zero


section .text
  global _start

_start:
  mov rax, -5

  ; --- 1. Check for Zero ---
  cmp rax, 0
  je  .is_zero ; If RAX == 0, jump to print "Zero"

  ; --- 2. Check for Positive (or fall through to Negative) ---
  cmp rax, 0       ; Re-compare (or just rely on flags from first cmp)
  jg  .is_positive ; If RAX > 0 (signed), jump to print "Positive"

  ; --- 3. Default: Must be Negative (RAX < 0) ---
.is_negative:
  mov rsi, msg_neg ; Load the "Negative" message address
  mov rdx, len_neg ; Load the message length
  jmp .print       ; Jump to the printing logic

.is_positive:
  mov rsi, msg_pos ; Load the "Positive" message address
  mov rdx, len_pos ; Load the message length
  jmp .print       ; Jump to the printing logic

.is_zero:
  mov rsi, msg_zero ; Load the "Zero" message address
  mov rdx, len_zero ; Load the message length
  ; Fall through to .print

.print:
  ; --- Syscall 1: sys_write (Arguments set up above) ---
  mov rax, 1 ; Syscall number
  mov rdi, 1 ; stdout file descriptor
  ; RSI and RDX are already set
  syscall

  ; --- Exit Syscall ---
  mov rax, 60
  mov rdi, 0
  syscall
