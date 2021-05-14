.data
.align 2
mensaje_1: .asciz "------------------- Bienvenido a la calculadora-------------------\n"
mensaje_2: .asciz "Seleccione operación a realizar:\n"
mensaje_3: .asciz "+  Suma\n"
mensaje_4: .asciz "*  Multiplicacion\n"
mensaje_5: .asciz "M  Modulo\n"
mensaje_6: .asciz "P  Potencian de un numero\n"
mensaje_7: .asciz "=  Mostrar el valor almacenado en memoria\n"
mensaje_8: .asciz "1  Ingresar primera cadena de caracteres\n"
mensaje_9: .asciz "2  Ingresar segunda cadena de caracteres\n"
mensaje_10: .asciz "C  Concatenar cadenas 1 y 2\n"
mensaje_11: .asciz "q  Mostrar mensaje de despedida y salir al sistemaoperativo\n"

mensaje_12: .asciz "Gracias por utilizar el programa\n"
mensaje_13: .asciz "  --> Comando elegido: Suma\n"
mensaje_14: .asciz "OCURRIO UN ERROR\n"
mensaje_15: .asciz "\n"
mensaje_16: .asciz "Ingrese el comando\n"
mensaje_17: .asciz "    Escribe el valor\n"
mensaje_18: .asciz "    Valor ingresado...\n"
mensaje_19: .asciz "  --> Comando elegido: Multiplicacion\n"
mensaje_20: .asciz "  --> Comando elegido: Potencia\n"
mensaje_21: .asciz "  --> Comando elegido: Modelo\n"
mensaje_22: .asciz "  --> Comando elegido: Ingresar primer cadena\n"
mensaje_23: .asciz "  --> Comando elegido: Ingresar sgeunda cadena\n"
string: .asciz "                             "
string_2: .asciz "                                                                        "
string_3: .asciz "                                                                        "
resultado: .word 0
enter: 	.asciz "\n"
strLen: .word 0
strNumVal: .word 0
resultadof: .word 0
testNum: .word 9
unchar: .asciz "  "
formato: .asciz "Valor de memoria actualizado %d\n"

.text
.global main
.func main

main:
   //Impresion del mensaje original
   ldr r1,=mensaje_1
   bl _print
   ldr r1,=mensaje_2
   bl _print
   ldr r1,=mensaje_3
   bl _print
   ldr r1,=mensaje_4
   bl _print
   ldr r1,=mensaje_5
   bl _print
   ldr r1,=mensaje_6
   bl _print
   ldr r1,=mensaje_7
   bl _print
   ldr r1,=mensaje_8
   bl _print
   ldr r1,=mensaje_9
   bl _print
   ldr r1,=mensaje_10
   bl _print
   ldr r1,=mensaje_11
   bl _print
   ldr r1,=mensaje_15
   bl _print

   /*Registro que se va a actualizar en memoria*/
   mov r9,#0

   /*Calculadora general, loop que corre infinitamente por el momento*/
   CalculadoraGeneral:
      ldr r1,=mensaje_16
      bl _print

      ldr r0,=string
      bl _keybread

      ldr r4,=string
      ldrb r4,[r4]

      cmp r4, #'+'
      beq sumando

      cmp r4, #'1'
      beq valor_1

      cmp r4, #'2'
      beq valor_2

      cmp r4, #'*'
      beq multiplicando

      cmp r4, #'P'
      beq potencia

      cmp r4, #'M'
      beq modulo

      cmp r4, #'q'
      beq saliendo

      cmp r4, #'='
      beq igual

      b error_inicial

   /*Si la opcion no se encuentra, muestra el mensaje*/
   error_inicial:
      ldr r1,=mensaje_14
      bl _print
      b CalculadoraGeneral
   
   /*Operacion de suma*/
   sumando:
   /*impresion de mensajes para mayor compresion*/
      ldr r1,=mensaje_15
      bl _print
      ldr r1,=mensaje_13
      bl _print
      ldr r1,=mensaje_15
      bl _print
      ldr r1,=mensaje_17
      bl _print
      

      ldr r0,=string
      bl _keybread

      ldr r1,=mensaje_18
      bl _print

      ldr r1,=string
      bl _print

      //Convierto un string de digito a numero
      ldr r0,=string
      ldr r1,=strNumVal
      bl _char2Num
   
      //Hago el comando de sumar
      ldr r1,=strNumVal
      ldr r0,[r1]
      add r0,r9
      mov r9,r0
      str r0,[r1]

      //Imprimo el resultado de el numero 
      ldr r1,=strNumVal
      ldr r1,[r1]
      ldr r0,=formato
      bl printf
      b CalculadoraGeneral

/*Operacion de Multiplicacion*/
   multiplicando:
   /*impresion de mensajes para mayor compresion*/
      ldr r1,=mensaje_15
      bl _print
      ldr r1,=mensaje_19
      bl _print
      ldr r1,=mensaje_15
      bl _print
      ldr r1,=mensaje_17
      bl _print
      

      ldr r0,=string
      bl _keybread

      ldr r1,=mensaje_18
      bl _print

      ldr r1,=string
      bl _print

      //Convierto un string de digito a numero
      ldr r0,=string
      ldr r1,=strNumVal
      bl _char2Num
   
      //Hago el comando de multiplicar
      ldr r1,=strNumVal
      ldr r0,[r1]
      mul r0,r9,r0
      mov r9,r0
      str r0,[r1]

      //Imprimo el resultado de el numero 
      ldr r1,=strNumVal
      ldr r1,[r1]
      ldr r0,=formato
      bl printf
      b CalculadoraGeneral

/*Operacion de Potencia*/
   potencia:
   /*impresion de mensajes para mayor compresion*/
      ldr r1,=mensaje_15
      bl _print
      ldr r1,=mensaje_20
      bl _print
      ldr r1,=mensaje_15
      bl _print
      ldr r1,=mensaje_17
      bl _print
      

      ldr r0,=string
      bl _keybread

      ldr r1,=mensaje_18
      bl _print

      ldr r1,=string
      bl _print

      //Convierto un string de digito a numero
      ldr r0,=string
      ldr r1,=strNumVal
      bl _char2Num
   
      //Hago el comando de potencia
      ldr r1,=strNumVal
      ldr r0,[r1]


      mov r10,#0
      procedimiento_potencia:
         add r10,#1
         mul r9,r9,r9
         cmp r10,r0
         bge procedimiento_potencia
      str r9,[r1]

      //Imprimo el resultado de el numero 
      ldr r1,=strNumVal
      ldr r1,[r1]
      ldr r0,=formato
      bl printf
      b CalculadoraGeneral

   /*Operacion de Modulo*/
   modulo:
   /*impresion de mensajes para mayor compresion*/
      ldr r1,=mensaje_15
      bl _print
      ldr r1,=mensaje_21
      bl _print
      ldr r1,=mensaje_15
      bl _print
      ldr r1,=mensaje_17
      bl _print
      

      ldr r0,=string
      bl _keybread

      ldr r1,=mensaje_18
      bl _print

      ldr r1,=string
      bl _print

      //Convierto un string de digito a numero
      ldr r0,=string
      ldr r1,=strNumVal
      bl _char2Num
   
      //Hago el comando de multiplicar
      ldr r1,=strNumVal
      ldr r0,[r1]
      mov r6,#0
      loopResta:
         sub r9,r0
         add r6,#1
         cmp r9,r0
         bge loopResta
      str r9,[r1]

      

      //Imprimo el resultado de el numero 
      ldr r1,=strNumVal
      ldr r1,[r1]
      ldr r0,=formato
      bl printf
      b CalculadoraGeneral

   valor_1:
      ldr r1,=mensaje_22
      bl _print

      ldr r0,=string_2
      bl _keybread

      ldr r1,=string_2
      bl _print
      b CalculadoraGeneral

   valor_2:
      ldr r1,=mensaje_23
      bl _print

      ldr r0,=string_3
      bl _keybread

      ldr r1,=string_3
      bl _print
      b CalculadoraGeneral

   igual:
      ldr r1,=resultadof
      str r9,[r1]
      ldr r1,=resultadof
      ldr r1,[r1]
      ldr r0,=formato
      bl printf
      b CalculadoraGeneral
   saliendo:
      ldr r1,=mensaje_12
      bl _print
      //No necesito guardar el LR antes, pues SWI maneja el retorno
      mov r7,#1
      swi 0

  
      
   
   
