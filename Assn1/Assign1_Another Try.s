.equ SWI_PrInt,0x6b        @ Write an Integer
.equ SWI_PrStr, 0x69       @ Write a null-ending string 
.equ Stdout,  1            @ Set output target to be Stdout

mov r5, #500
mov r6, #0
ldr r7, =1729

ST:
add r7,r7,#1     	@i+=1
mov r8,#0		@num=0
mov r3,#0		@case=0

cmp r6,r5		@compare count and n
beq exit		@if(count==n) then exit

mov r9,#0		@curr=0
LOOP:			
add r9,r9,#1	@cur+=1
mul r10,r9,r9	@r4=curr*curr
mul r4,r10,r9	@r4=curr*curr*curr
sub r2,r7,r4	@r2=i-(curr*curr*curr)

cmp r4,r7		@compare curr^3 with i
bgt ST		@ if curr^3 is greater then go to LOOP

B CUBE			@check if r2 is a cube
CHECK:
cmp r0,#0		@if r2 was cube then r0=1 else it is 0
beq LOOP		@if r2 was not a cube then return to LOOP
add r3,r3,#1	@ case+=1;
cmp r3,#1		@ compare r3 that is case with 1
moveq r8,r9		@if case==1 then r8=num=curr
cmp r3,#2
blt LOOP		@if r3>1 then go to inlop


INLOOP:		   
mul r10,r8,r8		@r2=num*num
mul r2,r10,r8		@r2=num*num*num
add r2,r2,r4		@r2=num^3+curr^3
cmp r2,r7			@compare r2 with i
beq LOOP			@if r2==i then go to LOOP 
add r6,r6,#1		@else we have found a number and we print it
@PRINT R7 here
mov r0,r7
mov r1,r0                 @ R1 = integer to print
mov R0,#Stdout            @ target is Stdout
swi SWI_PrInt
mov R0,#Stdout            @ print new line
ldr r1, =NL
swi SWI_PrStr

B ST				@Go to ST NOW



CUBE:            @check if r2 is a cube
mov r1,#0 		@i=0

BR:
add r1,r1,#1	@i+=1
mul r10,r1,r1	@r0=i*i
mul r0,r10,r1	@r0=i*i*i
cmp r0,r2
blt BR
moveq r0,#1
movgt r0,#0
B CHECK











exit:
swi 0x11

EXIT:
swi 0x11

.data
NL:          .asciz   "\n "        @ new line 
.end