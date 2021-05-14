
.data
.align 2
msg1: .asciz "------------------- Bienvenido a la calculadora-------------------\n"
msg2: .asciz "Seleccione operación a realizar:\n"
msg3: .asciz "+  Suma\n"
msg4: .asciz "*  Multiplicacion\n"
msg5: .asciz "M  Modulo\n"
msg6: .asciz "P  Potencian de un numero\n"
msg7: .asciz "=  Mostrar el valor almacenado en memoria\n"
msg8: .asciz "1  Ingresar primera cadena de caracteres\n"
msg9: .asciz "2  Ingresar segunda cadena de caracteres\n"
msg10: .asciz "C  Concatenar cadenas 1 y 2\n"
msg11: .asciz "q  Mostrar mensaje de despedida y salir al sistemaoperativo\n"
msg12: .asciz "\nEspero que la calculadora te fuera util. Saliendo...\n"
msg13: .asciz "  Esta es la operacion de suma\n"
msg14: .asciz "  No es suma...\n\n"
msg15: .asciz "\n"
msg16: .asciz "Ingrese una opcion\n"
msg17: .asciz "    Escribe el valor\n"
msg18: .asciz "    Valor ingresado...\n"
string: .asciz "                             "
string_2: .asciz "                             "
enter: 	.asciz "\n"
strLen: .word 0
strNumVal: .word 0
resultado: .word 0
testNum: .word 9
unchar: .asciz "  "
formato: .asciz "Valor de memoria actualizado %d\n"

.text
.global main
.func main

main:
   //Impresion del mensaje original
   ldr r1,=msg1
   bl _print
   ldr r1,=msg2
   bl _print
   ldr r1,=msg3
   bl _print
   ldr r1,=msg4
   bl _print
   ldr r1,=msg5
   bl _print
   ldr r1,=msg6
   bl _print
   ldr r1,=msg7
   bl _print
   ldr r1,=msg8
   bl _print
   ldr r1,=msg9
   bl _print
   ldr r1,=msg10
   bl _print
   ldr r1,=msg11
   bl _print
   ldr r1,=msg15
   bl _print

   /*Registro que se va a actualizar en memoria*/
   mov r9,#0

   /*Calculadora general, loop que corre infinitamente por el momento*/
   CalculadoraGeneral:
      ldr r1,=msg16
      bl _print

      ldr r0,=string
      bl _keybread

      ldr r4,=string
      ldrb r4,[r4]

      cmp r4, #'-'
      beq otro

      cmp r4, #'+'
      beq sumando

   /*Si la opcion no esta muestra el mensaje*/
   otro:
      ldr r1,=msg14
      bl _print
      b CalculadoraGeneral
   
   /*Operacion de suma*/
   sumando:
   /*impresion de mensajes para mayor compresion*/
      ldr r1,=msg15
      bl _print
      ldr r1,=msg13
      bl _print
      ldr r1,=msg15
      bl _print
      ldr r1,=msg17
      bl _print
      

      ldr r0,=string_2
      bl _keybread

      ldr r1,=msg18
      bl _print

      ldr r1,=string_2
      bl _print

      //Convierto un string de digito a numero
      ldr r0,=string_2
      ldr r1,=strNumVal
      bl _char2Num
   
      //Duplico el valor
      ldr r1,=strNumVal
      ldr r0,[r1]
      add r0,r9
      mov r9,r0
      str r0,[r1]

      //Imprimo el resultado de el numero + 2
      ldr r1,=strNumVal
      ldr r1,[r1]
      ldr r0,=formato
      bl printf
   
      
      

      b CalculadoraGeneral

   
   

  
      
   
   //No necesito guardar el LR antes, pues SWI maneja el retorno
   mov r7,#1
   swi 0
