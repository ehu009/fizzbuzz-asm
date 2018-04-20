.data                   # data segment
BUZZ:
  .ascii  "Buzz\n\0"
FIZZ:
  .ascii  "Fizz\n\0"
FIZZBUZZ:
  .ascii  "Fizzbuzz\n\0"
NUMBER:
  .ascii  "%d\n\0"      # format string for integer representations in printf

  
.text                   # code segment
  .type   fizzbuzz, @function
  .globl  fizzbuzz      # declare label for outside scope  
  .extern printf        # import label printf

fizzbuzz:   ////////////
  PUSHL %ebp
  MOVL  %esp, %ebp      # set stack frame
  PUSHL %ebx
  PUSHL %edx            # preserve caller reserved registers
  MOVL  $0,   %ebx      # 0 -> x
__loop:   //////////////
  ADDL  $1,       %ebx
  CMPL  8(%ebp),  %ebx  # while (x <= N)
    JLE   .check         # do { x + 1 -> x; ... }  
    POPL  %edx
    POPL  %ebx          # restore caller reserved registers
    POPL  %ebp          # undo stack frame
    RET                 # bye-bye

.divide:   //////////////
  MOVL  $0,   %edx      # edx:eax / x -> eax
  MOVL  %ebx, %eax      # edx:eax % x -> edx
  DIVL  %ecx            # ecx -> x
  RET

.check:    //////////////
  PUSHL %ebx            # push x
  JMP   .cascade         # see if x grants remainders equal to 0 for divisors 15, 5 and 3
__default:    //////////
  PUSHL $NUMBER         # non-fizzbuzz numbers grant integer representation
__check_end:    ////////
  CALL  printf
  ADDL  $8, %esp        # print something, then pop twice
  JMP   __loop          # keep going

/*  macro: if remainder is zero, push string pointer and stop looking */
#define ALERT(Q,Nxt,Str) MOVL  $(Q),  %ecx; \
    CALL  .divide;     \
    CMPL  $0,   %edx;   JNE   (Nxt);    \
      PUSHL Str;        JMP   __check_end;
.cascade:
__check15:    //////////
  ALERT(15, __check5, $FIZZBUZZ) 
__check5:   ////////////
  ALERT(5,  __check3, $BUZZ)
__check3:   ////////////
  ALERT(3,  __default,  $FIZZ)
