$MODDE0CV ; Sets some sort of mode
	; The display format depends on the states of switches SW2 down to SW0 after
	; they are latched by pressing pushbutton ‘KEY3’. In all the examples it is assumed that
	; the student number is “12345678”. 

case_000:
	; Display the six most significant digits of your student number using HEX5 down to
	; HEX0. For example: “123456” 

case_001:
	; Display the two least significant digits of your student number using HEX1 and
	; HEX0. Keep HEX5 down to HEX2 blank. For example: “ 78”

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

case_110:
	; Display “HELLO ” for one second, then the six most significant digits of your student
	; number for one second (for example “123456”), followed by “CPN312” for one second.
	; This should keep going forever until the selection for SW2 down to SW0 is changed. 

case_111:
	; Display your student number (or part of it) using a format of your own creation that
	; is different from any of the formats required above. 