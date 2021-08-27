;
; The code given to you here implements the histogram calculation that 
; we developed in class.  In programming lab, we will add code that
; prints a number in hexadecimal to the monitor.
;
; Your assignment for this program is to combine these two pieces of 
; code to print the histogram to the monitor.
;
; If you finish your program, 
;    ** commit a working version to your repository  **
;    ** (and make a note of the repository version)! **


	.ORIG	x3000		; starting address is x3000


;
; Count the occurrences of each letter (A to Z) in an ASCII string 
; terminated by a NUL character.  Lower case and upper case should 
; be counted together, and a count also kept of all non-alphabetic 
; characters (not counting the terminal NUL).
;
; The string starts at x4000.
;
; The resulting histogram (which will NOT be initialized in advance) 
; should be stored starting at x3F00, with the non-alphabetic count 
; at x3F00, and the count for each letter in x3F01 (A) through x3F1A (Z).
;
; table of register use in this part of the code
;    R0 holds a pointer to the histogram (x3F00)
;    R1 holds a pointer to the current position in the string
;       and as the loop count during histogram initialization
;    R2 holds the current character being counted
;       and is also used to point to the histogram entry
;    R3 holds the additive inverse of ASCII '@' (xFFC0)
;    R4 holds the difference between ASCII '@' and 'Z' (xFFE6)
;    R5 holds the difference between ASCII '@' and '`' (xFFE0)
;    R6 is used as a temporary register
;

	LD R0,HIST_ADDR      	; point R0 to the start of the histogram
	
	; fill the histogram with zeroes 
	AND R6,R6,#0		; put a zero into R6
	LD R1,NUM_BINS		; initialize loop count to 27
	ADD R2,R0,#0		; copy start of histogram into R2

	; loop to fill histogram starts here
HFLOOP	STR R6,R2,#0		; write a zero into histogram
	ADD R2,R2,#1		; point to next histogram entry
	ADD R1,R1,#-1		; decrement loop count
	BRp HFLOOP		; continue until loop count reaches zero

	; initialize R1, R3, R4, and R5 from memory
	LD R3,NEG_AT		; set R3 to additive inverse of ASCII '@'
	LD R4,AT_MIN_Z		; set R4 to difference between ASCII '@' and 'Z'
	LD R5,AT_MIN_BQ		; set R5 to difference between ASCII '@' and '`'
	LD R1,STR_START		; point R1 to start of string

	; the counting loop starts here
COUNTLOOP
	LDR R2,R1,#0		; read the next character from the string
	BRz PRINT_HIST		; found the end of the string

	ADD R2,R2,R3		; subtract '@' from the character
	BRp AT_LEAST_A		; branch if > '@', i.e., >= 'A'
NON_ALPHA
	LDR R6,R0,#0		; load the non-alpha count
	ADD R6,R6,#1		; add one to it
	STR R6,R0,#0		; store the new non-alpha count
	BRnzp GET_NEXT		; branch to end of conditional structure
AT_LEAST_A
	ADD R6,R2,R4		; compare with 'Z'
	BRp MORE_THAN_Z         ; branch if > 'Z'

; note that we no longer need the current character
; so we can reuse R2 for the pointer to the correct
; histogram entry for incrementing
ALPHA	ADD R2,R2,R0		; point to correct histogram entry
	LDR R6,R2,#0		; load the count
	ADD R6,R6,#1		; add one to it
	STR R6,R2,#0		; store the new count
	BRnzp GET_NEXT		; branch to end of conditional structure

; subtracting as below yields the original character minus '`'
MORE_THAN_Z
	ADD R2,R2,R5		; subtract '`' - '@' from the character
	BRnz NON_ALPHA		; if <= '`', i.e., < 'a', go increment non-alpha
	ADD R6,R2,R4		; compare with 'z'
	BRnz ALPHA		; if <= 'z', go increment alpha count
	BRnzp NON_ALPHA		; otherwise, go increment non-alpha

GET_NEXT
	ADD R1,R1,#1		; point to next character in string
	BRnzp COUNTLOOP		; go to start of counting loop



PRINT_HIST

; you will need to insert your code to print the histogram here

; do not forget to write a brief description of the approach/algorithm
; for your implementation, list registers used in this part of the code,
; and provide sufficient comments


; Intro Paragraph:
; partners: swhuang3, ycc6, dhhuang3
; I pack my code that print 4 digit number from Lab1 to a subroutine, with number parameter passed by R3.
; Then loop 27 times to iterate and print the 27 bins.
; partners: swhuang3, ycc6, dhhuang3

; Main code
; R0: char, OUT register
; R1: counter
; R2: tmp
; R3: PRINT_NUMBER parameter

; Function PRINT_NUMBER
; Registers:
;   R3: input parameter
;   R4: digitCounter
;   R5: digit
;   R6: bitCounter
;   R0: tmp


	LD R1, ZERO			; Clear counter to zero

PRINT_HIST_LOOP
	ADD R2, R1, #-16	; Check if counter < 27
	ADD R2, R2, #-11
	BRzp DONE			; End the code if counter >= 27

	LD R0, ASCII_AT		; Load ASCII "@" offset to R0
	ADD R0, R0, R1		; Add counter(R2) to R0 to get histogram index char
	OUT

	LD R0, ASCII_SPACE	; Output SPACE
	OUT


	LD R0, HIST_ADDR	; Load base address
	ADD R0, R0, R1		; Calculate histogram bin memory offset
	LDR R3, R0, #0		; Load histogram bin data to parameter R3
	JSR  PRINT_NUMBER	; Call PRINT_NUMBER subroutine with parameter R3
 

	LD R0, ASCII_NL		; Output newline
	OUT


	ADD R1, R1, #1		; Increase counter by one
	BRnzp PRINT_HIST_LOOP


	







DONE	HALT			; done



; Function PRINT_NUMBER
; Registers:
;   R3: input
;   R4: digitCounter
;   R5: digit
;   R6: bitCounter
;   R0: tmp
PRINT_NUMBER
    ST R0, R0_SAVE		; Save R0~R7 to memory
    ST R1, R1_SAVE
    ST R2, R2_SAVE
    ST R3, R3_SAVE
    ST R4, R4_SAVE
    ST R5, R5_SAVE
    ST R6, R6_SAVE
    ST R7, R7_SAVE


    LD  R4, ZERO		; Clear digitCounter
    ADD R4, R4, #4		; Set digitCounter

DIGIT_LOOP
    AND R4, R4, R4
    BRnz PRINT_NUMBER_END


    LD  R5, ZERO		; Clear digit
    LD  R6, ZERO		; Clear bitCounter
    ADD R6, R6, #4		; Set bitCounter

BIT_LOOP
    AND R6, R6, R6
    BRnz DISPLAY_DIGIT	; Display digit if all bit in digit is read


    ADD R5, R5, R5		; Left shift digit

    AND R3, R3, R3		; Check R3 MSB = 1 or 0
    BRn NUM_MSB_1
    BRnzp NUM_MSB_0

NUM_MSB_1
    ADD R5, R5, #1
    BRnzp NUM_MSB_END

NUM_MSB_0
    ADD R5, R5, #0
    BRnzp NUM_MSB_END

NUM_MSB_END

    ADD R3, R3, R3		; Left shift input


    ADD R6, R6, #-1		; Decrease bitCounter by one
    BRnzp BIT_LOOP




DISPLAY_DIGIT
    LD R0, ZERO
    ADD R0, R0, R5

    ADD R0, R0, #-9		; Check if display digit > 9 or not
    BRnz DIGIT_LE_9
    BRnzp DIGIT_GT_9

DIGIT_LE_9
    LD R0, ASCII_ZERO	; Output 0~9 if digit <= 9
    ADD R5, R5, R0

    BRnzp DIGIT_END

DIGIT_GT_9
    ADD R5, R5, #-10	; Output A~F if digit > 9

    LD R0, ASCII_A_CAP
    ADD R5, R5, R0

    BRnzp DIGIT_END

DIGIT_END				; Output digit to console
    LD R0, ZERO
    ADD R0, R0, R5
    OUT	


    ADD R4, R4, #-1		; Decrease digitCounter by one
    BRnzp DIGIT_LOOP

PRINT_NUMBER_END
    LD R0, R0_SAVE		; Load R0~R7 from memory
    LD R1, R1_SAVE
    LD R2, R2_SAVE
    LD R3, R3_SAVE
    LD R4, R4_SAVE
    LD R5, R5_SAVE
    LD R6, R6_SAVE
    LD R7, R7_SAVE
    RET



; the data needed by the program
NUM_BINS	.FILL #27	; 27 loop iterations
NEG_AT		.FILL xFFC0	; the additive inverse of ASCII '@'
AT_MIN_Z	.FILL xFFE6	; the difference between ASCII '@' and 'Z'
AT_MIN_BQ	.FILL xFFE0	; the difference between ASCII '@' and '`'
HIST_ADDR	.FILL x3F00     ; histogram starting address
STR_START	.FILL x4000	; string starting address


ZERO        .FILL x0000
ASCII_ZERO  .FILL x0030
ASCII_A_CAP .FILL x0041
ASCII_AT	.FILL x0040
ASCII_NL	.FILL x000A 
ASCII_SPACE	.FILL x0020

R0_SAVE     .FILL 0
R1_SAVE     .FILL 0
R2_SAVE     .FILL 0
R3_SAVE     .FILL 0
R4_SAVE     .FILL 0
R5_SAVE     .FILL 0
R6_SAVE     .FILL 0
R7_SAVE     .FILL 0

; for testing, you can use the lines below to include the string in this
; program...
; STR_START	.FILL STRING	; string starting address
; STRING		.STRINGZ "This is a test of the counting frequency code.  AbCd...WxYz."



	; the directive below tells the assembler that the program is done
	; (so do not write any code below it!)

	.END
