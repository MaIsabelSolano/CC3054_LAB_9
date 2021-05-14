.data
.align 2
strLen4print: .word 0
unidades: .word 0
decenas: .word 00
centenas: .word 000
putsNewline: .asciz " "


.text
.align 2
.global _keybread
_keybread:
@ Lee el caracter
  MOV R1,R0     @copia el parametro del puntero a la cadena
  MOV R7, #3		@3=llamado a "read" swi
  MOV R0, #0		@0=stdin (teclado)
  MOV R2, #11		@longitud de la cadena: 10 caracteres + enter
  SWI 0
  BX LR

/* ************
 * _print
 * ************
 * Displays a CR terminated string to STDOUT
 * IN: R1 - string pointer, R0 - string length
 */
.global _print
_print:
  PUSH {LR}     @ copy of LR because I will call _strlen here
  LDR R8,=strLen4print
  BL _strlen
  LDR R2,[R8]
  MOV R7, #4		@4=llamado a "write" swi
  MOV R0, #1		@1=stdout (monitor)
  SWI 0
  POP {LR}
  BX LR /*-- _print --*/


/* ************
 * _strlen
 * ************
 * Checks the length of a CR terminated string (Enter)
 * IN: R1 - string pointer
 * OUT: R8 - string length pointer
 */
.global _strlen
_strlen:
  MOV R0,R1
  length .req R5
  MOV length,#0
countchars:
  LDRB R4,[R0],#1
  CMP R4,#'\n'      @CR to check end of line
  BEQ endOfLine
  ADD length,#1
  B countchars
endOfLine:
  ADD length,#1
  STR length,[R8]
  .unreq length
  SWI 0
  BX LR /*-- _strlen --*/


/* ************
 * _char2Num
 * ************
 * Converts a char Digit to its number
 * IN: R0 - char pointer   R1 - digit value pointer
 */
.global _char2Num
_char2Num:
  charPointer .req R0
  valPointer .req R1

  

  LDRB R0,[charPointer]
  CMP R0,#0x30      @ Is the hex ascii value between 0
  CMPGE R0,#0x39    @ or 9
  SUBLE R0,#0x30    @ subtract 0x30 only if it's a digit
  STRLE R0,[valPointer] @ store value only if it un digito
  .unreq charPointer
  .unreq valPointer
  SWI 0
  BX LR


