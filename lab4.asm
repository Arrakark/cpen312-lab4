$MODDE0CV ; Sets some sort of mode
	; The display format depends on the states of switches SW2 down to SW0 after
	; they are latched by pressing pushbutton ‘KEY3’. In all the examples it is assumed that
	; the student number is “12345678”. 

	; Define student number
N_2 equ 01100001b
N_6 equ 01100001b
N_9 equ 01100001b
N_5 equ 01100001b
N_1 equ 01100001b
N_0 equ 01100001b
BLANK equ 01111111b
L_E equ 01100001b
N_4 equ 01100001b
L_D equ 01100001b
L_A equ 01100001b
L_C equ 01100001b

org 0
	ljmp init
	
init:
	mov SP, #0x7f ; Initialize the stack
	ljmp main_poll
	
main_poll:
	; Call different functions based on the latching of SW2 down to SW0
	jb KEY.3, cont ; jump if 1 (key is not pressed)
	; set new command (state of switches) into R1
	mov R1, SWA
	mov A, R1 ; need to invert buttons since they are active low
	cpl A
	mov R1, A
cont:
	; Execute last command
	cnje R1, #0, cc1 ; branches to the specified destination if their values are not equal
	lcall case_000
cc1: 
	cnje R1, #1, cc2
	lcall case_001
cc2: 
	cnje R1, #2, cc3
	lcall case_010
cc3: 
	cnje R1, #3, cc4
	lcall case_011
cc4: 
	cnje R1, #4, cc5
	lcall case_100
cc5: 
	cnje R1, #5, cc6
	lcall case_101
cc6: 
	cnje R1, #6, cc7
	lcall case_110
cc7: 
	lcall case_111
	ljump main_poll
	
wait_1_sec:
    mov R3, #180  ; 90 is 5AH
L3: mov R2, #250 ; 250 is FAH 
L2: mov R1, #250
L1: djnz R1, L1  ; 3 machine cycles-> 3*30ns*250=22.5us
	jb KEY.3, main_poll ; if the key is pressed jump immediately back to the main loop
    djnz R2, L2  ; 22.5us*250=5.625ms
    djnz R3, L3  ; 5.625ms*180=1s (approximately)
	ret

case_000:
	; Display the six most significant digits of your student number using HEX5 down to
	; HEX0. For example: “123456” 
	mov HEX5, #N_2
	mov HEX4, #N_6
	mov HEX3, #N_9
	mov HEX2, #N_5
	mov HEX1, #N_1
	mov HEX0, #N_1
	ret


case_001:
	; Display the two least significant digits of your student number using HEX1 and
	; HEX0. Keep HEX5 down to HEX2 blank. For example: “ 78”
	mov HEX5, #BLANK
	mov HEX4, #BLANK
	mov HEX3, #BLANK
	mov HEX2, #BLANK
	mov HEX1, #N_6
	mov HEX0, #N_0
	ret

case_010:
	;  Starting with the six most significant digits of your student number, scroll one digit
	; to the left every second. This should keep going forever until the selection for SW2
	; down to SW0 is changed. For example: “123456”, “234567”, “345678”, “456781”,
	; “567812”, “678123”, etc. 

case_011:
	; Starting with the six most significant digits of your student number, scroll the digits
	; of your student number one digit to the right every second. This should keep going
	; forever until the selection for SW2 down to SW0 is changed. For example: “123456”,
	; “812345”, “781234”, “678123”, “567812”, “456781”, etc. 

case_100:
	; Make the six least significant digits of your student number blink every second.
	; This should keep going forever until the selection for SW2 down to SW0 is changed. For
	; example: “345678”, “ “, “345678”, “ “, etc. 

case_101:
	; Make the six most significant digits of your student number appear one at time
	; every second, starting with a blank display. This should keep going forever until the
	; selection for SW2 down to SW0 is changed. For example: “ “, “1 ”, “12 ”,
	; “123 ”, “1234 ”, “12345 ”, “123456”, “ “,“1 ”, etc. 
	mov HEX5, #BLANK
	mov HEX4, #BLANK
	mov HEX3, #BLANK
	mov HEX2, #BLANK
	mov HEX1, #BLANK
	mov HEX0, #BLANK
	lcall wait_1_sec
	mov HEX5, #N_2
	mov HEX4, #BLANK
	mov HEX3, #BLANK
	mov HEX2, #BLANK
	mov HEX1, #BLANK
	mov HEX0, #BLANK
	lcall wait_1_sec
	mov HEX5, #N_2
	mov HEX4, #N_6
	mov HEX3, #BLANK
	mov HEX2, #BLANK
	mov HEX1, #BLANK
	mov HEX0, #BLANK
	lcall wait_1_sec
	mov HEX5, #N_2
	mov HEX4, #N_6
	mov HEX3, #N_9
	mov HEX2, #BLANK
	mov HEX1, #BLANK
	mov HEX0, #BLANK
	lcall wait_1_sec
	mov HEX5, #N_2
	mov HEX4, #N_6
	mov HEX3, #N_9
	mov HEX2, #N_5
	mov HEX1, #BLANK
	mov HEX0, #BLANK
	lcall wait_1_sec
	mov HEX5, #N_2
	mov HEX4, #N_6
	mov HEX3, #N_9
	mov HEX2, #N_5
	mov HEX1, #N_1
	mov HEX0, #BLANK
	lcall wait_1_sec
	mov HEX5, #N_2
	mov HEX4, #N_6
	mov HEX3, #N_9
	mov HEX2, #N_5
	mov HEX1, #N_1
	mov HEX0, #N_1
	ret

case_110:
	; Display “HELLO ” for one second, then the six most significant digits of your student
	; number for one second (for example “123456”), followed by “CPN312” for one second.
	; This should keep going forever until the selection for SW2 down to SW0 is changed.
	mov HEX5, #L_H
	mov HEX4, #L_E
	mov HEX3, #L_L
	mov HEX2, #L_L
	mov HEX1, #L_O
	mov HEX0, #BLANK
	lcall wait_1_sec
	lcall case_000
	lcall wait_1_sec
	mov HEX5, #L_C
	mov HEX4, #L_P
	mov HEX3, #L_N
	mov HEX2, #N_3
	mov HEX1, #N_2
	mov HEX0, #N_1
	lcall wait_1_sec
	ret
	
case_111:
	; Display your student number (or part of it) using a format of your own creation that
	; is different from any of the formats required above. 
	; display in base 18: e4d4ac
	mov HEX5, #L_E
	mov HEX4, #N_4
	mov HEX3, #L_D
	mov HEX2, #N_4
	mov HEX1, #L_A
	mov HEX0, #L_C
	ret
	