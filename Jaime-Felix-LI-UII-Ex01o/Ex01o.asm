					TITLE	Examen Unidad II Tipo o
					PAGE	60, 132

; Incluir las macros
Include Macros.inc

; Prototipos de llamadas al sistema operativo
GetStdHandle	PROTO	:QWORD
ReadConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
WriteConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
ExitProcess		PROTO	CodigoSalida:QWORD

				.DATA
; Definir las variables Cal01, Cal02, Cal03, Cal04, Cal05, Promedioasí como los mensajes de entrada correspondientes
; y los mensajes de salida
Cal01			QWORD	0
Promedio		QWORD	0
MenEnt01		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'l', 'a', ' ', 'c', 'a', 'l', 'i', 'f', 'i', 'c', 'a', 'c', 'i', 'ó', 'n', ' ', '1', ':', ' '
MenSal01		WORD	'A', 'L', 'U', 'M', 'N', 'O', ' ', 'A', 'P', 'R', 'O', 'B', 'A', 'D', 'O'

; Variables utilizadas por las llamadas al sistema
ManejadorE		QWORD	?
ManejadorS		QWORD	?
Caracteres		QWORD	?
Texto			WORD	13 DUP ( ? )				; Variable temporal para conversión Entero - Cadena, Cadena - Entero
SaltoLinea		WORD	13, 10
STD_INPUT		EQU		-10
STD_OUTPUT		EQU		-11

				.CODE
Principal		PROC

				; Alinear espacio en la pila
				SUB		RSP, 40

				; Obtener manejador estándar del teclado
				MOV		RCX, STD_INPUT
				CALL	GetStdHandle
				MOV		ManejadorE, RAX

				; Obtener manejador estándar de la consola
				MOV		RCX, STD_OUTPUT
				CALL	GetStdHandle
				MOV		ManejadorS, RAX

				; Solicitar la variable Cal01
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, MenEnt01				; Dirección de la cadena a escribir
				MOV		R8, LENGTHOF MenEnt01		; Número de caracteres a escribir
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				MOV		RCX, ManejadorE				; Manejador del teclado donde se lee la cadena
				LEA		RDX, Texto					; Dirección de la cadena a leer
				MOV		R8, LENGTHOF Texto			; Número de caracteres máximo a leer
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres leídos
				MOV		R10, 0						; Reservado para uso futuro
				CALL	ReadConsoleW
				MacroCadenaAEntero	Texto, Cal01

				; Solicitar la variable Cal02
				; Solicitar la variable Cal03
				; Solicitar la variable Cal04
				; Solicitar la variable Cal05

				; Calcular el promedio
				; Promedio = (Cal01 + Cal02 + Cal03 + Cal04 + Cal05) / 5

				; Si el promedio es mayor o igual a 70
				; Mostrar mensaje ALUMNO APROBADO
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, MenSal01				; Dirección de la cadena a escribir
				MOV		R8, LENGTHOF MenSal01		; Número de caracteres a escribir
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				; Si el promedio es menor que 70
				; Mostrar mensaje ALUMNO REPROBADO

				; Salto de línea
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, SaltoLinea				; Dirección de la cadena a escribir
				MOV		R8, LENGTHOF SaltoLinea		; Número de caracteres a escribir
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				; Salir al sistema operativo
				MOV		RCX, 0
				CALL	ExitProcess

Principal		ENDP
				END