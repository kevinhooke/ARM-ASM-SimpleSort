/*
R0 address of string used with printf ti output %d

R4 address of numbers to sort
R5 current number to be compared
R6 offset index for outer loop through numbers
R7 offset index for inner loop
R8 current smallest identified value
R9 current offset index of next uncompared value
*/
.global main
main:
  push {ip, lr}
  MOV R6, #0 			@outerloop offset to numbers to be sorted
  MOV R7, #0			@innerloop offers to number to be sorted
  MOV R8, #99			@large default for initial comparison
  MOV R9, #0			@init value for index to next uncompared value
outerLoop:
  MOV R7,R6				@copy outerloop offset to next starting offset for the innerloop
innerLoop:
  LDR R0, =output 		@load addr of output string
  LDR R4, =nums 		@ addr of string to R4
  LDR R5,[R4,R7] 		@load current num to R5 from R4 with offset R7
  MOV R1,R5 			@move num for output
  BL printf
  CMP R5,R8				@is current < smallest so far
  BLT swapSmallest		@if true, swap smallest to current first position then continue
continue:
  CMP R7,#16    		@ 0 plus 4*4bytes for 5 entries in array
  ADD R7, R7,#4 		@inc offset by 4 bytes
  BLT innerLoop
continueOuterLoop:
  CMP R6, #16
  ADD R6, R6, #4
  BLT outerLoop
_exit:
  POP {ip, lr}
writeSmallest:
  LDR R0, =smallest 	@load addr of output string
  MOV R1,R8 			@move num for output
  BL printf
doExit:
  MOV R1, #0
  MOV R7, #1
  SWI 0
swapSmallest:
  MOV R8,R5				@keep copy of smallest in the current loop
  MOV R8,R5				@swap the current smallest value into the current first position
  BX lr					@return
nums:
.word 5,2,7,1,8
.data
output:
.asciz "%d\n"
smallest:
.asciz "Smallest: %d\n"
.balign 4
sorted: .skip 20

