bits 64

; This function calculates GCD(A, B) using Euclidean Algorithm
; Input: A in RDI (1st arg), B in RSI (2nd arg)
; Output: GCD in RAX

section .text
  global gcd
gcd:
  ; --- FUNCTION PROLOGUE ---
  push rbp      ; 1. Save the caller's RBP
  mov  rbp, rsp ; 2. Set up the function's base pointer
  push rbx      ; 3. Callee-save: RBX must be preserved if we use it

  ; The arguments A and B are already in RDI and RSI

.loop_start:
  ; Check if B (RSI) is zero. If so, A (RDI) is the GCD.
  cmp rsi, 0    ; Compare B with 0
  je  .loop_end ; If B == 0, jump to the end

  ; C-like: temp = A % B  (Modulo operation)
  ; This is done by performing A / B and getting the remainder (RDX)
  mov rax, rdi ; Move A into RAX (dividend)
  xor rdx, rdx ; Clear RDX (required before DIV)
  div rsi      ; Divide RDX:RAX by RSI (B). Remainder goes into RDX.

  ; C-like: A = B
  mov rdi, rsi ; Set A (RDI) = B (RSI)

  ; C-like: B = temp
  mov rsi, rdx ; Set B (RSI) = Remainder (RDX)

  jmp .loop_start ; Loop back

.loop_end:
  mov rax, rdi ; The final answer (GCD) is in RDI (which was A). Move to RAX for return value.

  ; --- FUNCTION EPILOGUE ---
  pop rbx ; 1. Restore the original value of callee-saved RBX
  pop rbp ; 2. Restore the caller's RBP (tears down the stack frame)
  ret     ; 3. Return to the instruction address saved by the CALL

; ----------------------------------------------------------------------
; MAIN PROGRAM EXECUTION
; ----------------------------------------------------------------------
  global _start
_start:
  ; Test Case: GCD(48, 18). Expected result: 6
  mov rdi, 48 ; 1st arg (A) in RDI
  mov rsi, 18 ; 2nd arg (B) in RSI
  
  call gcd ; Call the function. RAX will receive the result (6).
  
  ; RAX is now 6. We exit the program, returning 6 as the status code.
  ; --- Exit Syscall (60) ---
  mov     rdi, rax ; Move the result (6) into the exit status register (RDI)
  mov     rax, 60  ; Syscall number for sys_exit
  syscall          ; Execute exit
