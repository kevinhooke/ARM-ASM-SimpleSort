/*
R0 address of string used with printf ti output %d

R4 address of numbers to sort
R5 current number to be compared
R6 offset index for looping through numbers
R7 current smallest
*/
.global main
main:
  push {ip, lr}
  MOV R6, #0 			@offset to data
  MOV R7, #99			@large default for initial comparison
loop:
  LDR R0, =output 		@load addr of output string
  LDR R4, =nums 		@ addr of string to R4
  LDR R5,[R4,R6] 		@load current num to R5 from R4 with offset R6
  MOV R1,R5 			@move num for output
  BL printf
  CMP R5,R7
  BLT copySmallest
continue:
  CMP R6,#16    		@ 0 plus 4*4bytes for 5 entries in array
  ADD R6,R6, #4 		@inc offset by 4 bytes
  BNE loop
_exit:
  POP {ip, lr}
writeSmallest:
  LDR R0, =smallest 	@load addr of output string
  MOV R1,R7 			@move num for output
  BL printf
doExit:
  MOV R1, #0
  MOV R7, #1
  SWI 0
copySmallest:
  MOV R7,R5
  BL continue
nums:
.word 5,2,7,1,8
.data
output:
.asciz "%d\n"
smallest:
.asciz "Smallest: %d\n"
.balign 4
sorted: .skip 20

