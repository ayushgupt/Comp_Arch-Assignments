.equ SWI_PrInt,0x6b        @ Write an Integer
.equ SWI_PrStr, 0x69       @ Write a null-ending string 
.equ Stdout,  1            @ Set output target to be Stdout

mov r2,#0 @count=0
mov r3,#4 @ n=5
mov r4,#1 @ i=0
LABA:
cmp r2,r3
beq exit
add r4,r4,#1 @i+=1;
mov r5,#0  @ cas=0;

@@@@r6 =int of cbrt
B CUBE
CHECK:
mov r6,r0


mov r7,#0 @ a=0

LABB:
add r7,r7,#1 @a=a+1
cmp r7,r6
bgt LABA
mov r8,r7 @ b=a

LABC:
add r8,r8,#1 @ b+=1
cmp r8,r6
bgt LABB
mul r10,r7,r7
mul r9,r10,r7 @ r9=a^3
mul r11,r8,r8
mul r10,r11,r8 @ r10=b^3
add r9,r9,r10 @r9=a^3+b^3
cmp r9,r4;
bne LABC
add r5,r5,#1 @ cas+=1
cmp r5,#2
blt LABC
add r2,r2,#1
@@@@@@@@@@@@@@@@@@@@@@Print r4
mov r1,r4                 @ R1 = integer to print
mov R0,#Stdout            @ target is Stdout
swi SWI_PrInt
mov R0,#Stdout            @ print new line
ldr r1, =NL
swi SWI_PrStr

B LABA



CUBE:            @r0=min of cbrt of r6
mov r1,#0 		@i=0

BR:
add r1,r1,#1	@i+=1
mul r10,r1,r1	@r0=i*i
mul r0,r10,r1	@r0=i*i*i
cmp r0,r4
blt BR
moveq r0,r1
movgt r0,r1
B CHECK











exit:
swi 0x11

EXIT:
swi 0x11

.data
NL:          .asciz   "\n "        @ new line 
.end