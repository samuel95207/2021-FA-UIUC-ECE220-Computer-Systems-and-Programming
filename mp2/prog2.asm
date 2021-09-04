;
;
;
.ORIG x3000
	
;your code goes here
MAIN_LOOP	
    GETC


CHECK_EQUAL
	LD R1, ASCII_EQUAL
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz CHECK_COMPLETE

CHECK_ADD
	LD R1, ASCII_ADD
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz CHECK_COMPLETE

CHECK_SUB
	LD R1, ASCII_SUB
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz CHECK_COMPLETE

CHECK_MUL
	LD R1, ASCII_MUL
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz CHECK_COMPLETE

CHECK_DIV
	LD R1, ASCII_DIV
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz CHECK_COMPLETE

CHECK_EXP
	LD R1, ASCII_EXP
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz CHECK_COMPLETE

CHECK_SPACE
	LD R1, ASCII_SPACE
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz CHECK_COMPLETE

CHECK_NUMBER
	LD R1, ASCII_ZERO
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz CHECK_COMPLETE
	BRn PRINT_INVALID
CHECK_NUMBER2
	ADD R1, R1, #-10
	BRzp PRINT_INVALID

CHECK_COMPLETE
	OUT
	JSR EVALUATE

	BRnzp MAIN_LOOP







PRINT_INVALID
	LEA R0, STRING_INVALID
	PUTS
	HALT


STRING_INVALID	.STRINGZ "Invalid Expression"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;R3- value to print in hexadecimal
PRINT_HEX
    ST R0, R0_SAVE
    ST R1, R1_SAVE
    ST R2, R2_SAVE
    ST R3, R3_SAVE
    ST R4, R4_SAVE
    ST R5, R5_SAVE
    ST R6, R6_SAVE
    ST R7, R7_SAVE


    LD  R4, ZERO
    ADD R4, R4, #4

DIGIT_LOOP
    AND R4, R4, R4
    BRnz PRINT_NUMBER_END


    LD  R5, ZERO
    LD  R6, ZERO
    ADD R6, R6, #4

BIT_LOOP
    AND R6, R6, R6
    BRnz DISPLAY_DIGIT


    ADD R5, R5, R5

    AND R3, R3, R3
    BRn NUM_MSB_1
    BRnzp NUM_MSB_0

NUM_MSB_1
    ADD R5, R5, #1
    BRnzp NUM_MSB_END

NUM_MSB_0
    ADD R5, R5, #0
    BRnzp NUM_MSB_END

NUM_MSB_END

    ADD R3, R3, R3


    ADD R6, R6, #-1
    BRnzp BIT_LOOP




DISPLAY_DIGIT
    LD R0, ZERO
    ADD R0, R0, R5

    ADD R0, R0, #-9
    BRnz DIGIT_LE_9
    BRnzp DIGIT_GT_9

DIGIT_LE_9
    LD R0, ASCII_ZERO
    ADD R5, R5, R0

    BRnzp DIGIT_END

DIGIT_GT_9
    ADD R5, R5, #-10

    LD R0, ASCII_A_CAP
    ADD R5, R5, R0

    BRnzp DIGIT_END

DIGIT_END
    LD R0, ZERO
    ADD R0, R0, R5
    OUT	


    ADD R4, R4, #-1
    BRnzp DIGIT_LOOP

PRINT_NUMBER_END
    LD R0, R0_SAVE
    LD R1, R1_SAVE
    LD R2, R2_SAVE
    LD R3, R3_SAVE
    LD R4, R4_SAVE
    LD R5, R5_SAVE
    LD R6, R6_SAVE
    LD R7, R7_SAVE
    RET


END
    halt

ZERO        .FILL x0000
NUM         .FILL x0A3F
ASCII_A_CAP .FILL x0041

R0_SAVE     .FILL 0
R1_SAVE     .FILL 0
R2_SAVE     .FILL 0
R3_SAVE     .FILL 0
R4_SAVE     .FILL 0
R5_SAVE     .FILL 0
R6_SAVE     .FILL 0
R7_SAVE     .FILL 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;R0 - character input from keyboard
;R6 - current numerical output
;
;
;your code goes here
EVALUATE
	ST R0, EVALUATE_SaveR0
	ST R1, EVALUATE_SaveR1
	ST R3, EVALUATE_SaveR3
	ST R4, EVALUATE_SaveR4
	ST R5, EVALUATE_SaveR5
	ST R7, EVALUATE_SaveR7


EVALUATE_CHECK_SPACE
	LD R1, ASCII_SPACE
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz EVALUATE_RET

EVALUATE_CHECK_EQUAL
	LD R1, ASCII_EQUAL
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz EVALUATE_EQUAL

EVALUATE_CHECK_NUMBER
	LD R1, ASCII_ZERO
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R0, R1
	BRz EVALUATE_OPERAND
	BRn EVALUATE_OPERATOR
EVALUATE_CHECK_NUMBER_NUMBER2
	ADD R1, R1, #-10
	BRzp EVALUATE_OPERATOR
	BRnzp EVALUATE_OPERAND

EVALUATE_EQUAL
	JSR STACK_SIZE
	ADD R5, R5, #-1
	BRnp PRINT_INVALID
	JSR POP
	
	ADD R3, R0, #0
	JSR PRINT_HEX
	BRnzp END



EVALUATE_OPERAND
	LD R1, ASCII_ZERO
	NOT R1, R1
	ADD R1, R1, #1
	ADD R0, R0, R1
	JSR PUSH
	BRnzp EVALUATE_RET


EVALUATE_OPERATOR
	ADD R1, R0, #0

	JSR POP
	AND R5, R5, R5
	BRp PRINT_INVALID
	ADD R4, R0, #0

	JSR POP
	AND R5, R5, R5
	BRp PRINT_INVALID
	ADD R3, R0, #0


	LD R0, ASCII_ADD
	NOT R0, R0
	ADD R0, R0, #1
	ADD R0, R0, R1
	BRz EVALUATE_OPERATOR_ADD

	LD R0, ASCII_SUB
	NOT R0, R0
	ADD R0, R0, #1
	ADD R0, R0, R1
	BRz EVALUATE_OPERATOR_SUB

	LD R0, ASCII_MUL
	NOT R0, R0
	ADD R0, R0, #1
	ADD R0, R0, R1
	BRz EVALUATE_OPERATOR_MUL

	LD R0, ASCII_DIV
	NOT R0, R0
	ADD R0, R0, #1
	ADD R0, R0, R1
	BRz EVALUATE_OPERATOR_DIV

	LD R0, ASCII_EXP
	NOT R0, R0
	ADD R0, R0, #1
	ADD R0, R0, R1
	BRz EVALUATE_OPERATOR_EXP

EVALUATE_OPERATOR_ADD
	JSR PLUS
	BRnzp EVALUATE_OPERATOR_COMPLETE
EVALUATE_OPERATOR_SUB
	JSR MIN
	BRnzp EVALUATE_OPERATOR_COMPLETE
EVALUATE_OPERATOR_MUL
	JSR MUL
	BRnzp EVALUATE_OPERATOR_COMPLETE
EVALUATE_OPERATOR_DIV
	JSR DIV
	BRnzp EVALUATE_OPERATOR_COMPLETE
EVALUATE_OPERATOR_EXP
	JSR EXP
	BRnzp EVALUATE_OPERATOR_COMPLETE


EVALUATE_OPERATOR_COMPLETE
	JSR PUSH

EVALUATE_RET

	ST R0, EVALUATE_SaveR0
	ST R1, EVALUATE_SaveR1
	ST R3, EVALUATE_SaveR3
	ST R4, EVALUATE_SaveR4
	ST R5, EVALUATE_SaveR5
	LD R7, EVALUATE_SaveR7
	RET




EVALUATE_SaveR0 .BLKW #1
EVALUATE_SaveR1 .BLKW #1
EVALUATE_SaveR3 .BLKW #1
EVALUATE_SaveR4 .BLKW #1
EVALUATE_SaveR5 .BLKW #1
EVALUATE_SaveR7 .BLKW #1


ASCII_SPACE     .FILL x0020
ASCII_ADD		.FILL x002B
ASCII_SUB		.FILL x002D
ASCII_MUL		.FILL x002A
ASCII_DIV		.FILL x002F
ASCII_EQUAL		.FILL x003D
ASCII_EXP		.FILL x005E
ASCII_ZERO		.FILL x0030


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
PLUS	
;your code goes here
	ADD R0, R3, R4

RET
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
MIN	
;your code goes here
	ST R4, MIN_SAVER4
	ST R7, MIN_SAVER7

	NOT R4, R4
	ADD R4, R4, #1	
	ADD R0, R3, R4

	LD R4, MIN_SAVER4
	LD R7, MIN_SAVER7
	RET

MIN_SaveR4     .BLKW #1
MIN_SaveR7     .BLKW #1




	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0

; R5: R3 neg flag
; R6: R4 neg flag
MUL	

;your code goes here
	ST R3, MUL_SAVER3
	ST R4, MUL_SAVER4
	ST R5, MUL_SAVER5
	ST R6, MUL_SAVER6
	ST R7, MUL_SAVER7

	AND R0, R0, #0
	AND R5, R5, #0
	AND R6, R6, #0


	AND R3, R3, R3
	BRn MUL_R3_NEG
	BRnzp MUL_NEXT_1

MUL_R3_NEG
	ADD R5, R5, #1
	NOT R3, R3
	ADD R3, R3, #1

MUL_NEXT_1
	AND R4, R4, R4
	BRn MUL_R4_NEG
	BRnzp MUL_NEXT_2

MUL_R4_NEG
	ADD R6, R6, #1
	NOT R4, R4
	ADD R4, R4, #1

MUL_NEXT_2
	AND R3, R3, R3
	BRz MUL_END

MUL_LOOP
	ADD R0, R0, R4

	ADD R3, R3, #-1
	BRp MUL_LOOP

	ADD R5, R5, R6
	AND R5, R5, #1
	BRz MUL_END

	NOT R0, R0
	ADD R0, R0, #1
MUL_END
	LD R3, MUL_SAVER3
	LD R4, MUL_SAVER4
	LD R5, MUL_SAVER5
	LD R6, MUL_SAVER6
	LD R7, MUL_SAVER7

	RET

MUL_SaveR3     .BLKW #1
MUL_SaveR4     .BLKW #1
MUL_SaveR5     .BLKW #1
MUL_SaveR6     .BLKW #1
MUL_SaveR7     .BLKW #1



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
DIV	
;your code goes here
	ST R3, DIV_SAVER3
	ST R4, DIV_SAVER4
	ST R5, DIV_SAVER5
	ST R6, DIV_SAVER6
	ST R7, DIV_SAVER7

	AND R0, R0, #0

	NOT R4, R4
	ADD R4, R4, #1	

DIV_LOOP
	ADD R3, R3, R4
	BRn DIV_END

	ADD R0, R0, #1
	BRnzp DIV_LOOP

DIV_END

	LD R3, DIV_SAVER3
	LD R4, DIV_SAVER4
	LD R5, DIV_SAVER5
	LD R6, DIV_SAVER6
	LD R7, DIV_SAVER7

	RET




DIV_SaveR3     .BLKW #1
DIV_SaveR4     .BLKW #1
DIV_SaveR5     .BLKW #1
DIV_SaveR6     .BLKW #1
DIV_SaveR7     .BLKW #1
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
EXP
;your code goes here
	ST R3, EXP_SAVER3
	ST R4, EXP_SAVER4
	ST R5, EXP_SAVER5
	ST R6, EXP_SAVER6
	ST R7, EXP_SAVER7


	AND R0, R0, #0
	ADD R0, R0, #1
	ADD R6, R4, #0

	BRz EXP_END


EXP_LOOP
	ADD R4, R0, #0
	JSR MUL

	ADD R6, R6, #-1
	BRp EXP_LOOP

EXP_END
	LD R3, EXP_SAVER3
	LD R4, EXP_SAVER4
	LD R5, EXP_SAVER5
	LD R6, EXP_SAVER6
	LD R7, EXP_SAVER7


	RET


EXP_SaveR3     .BLKW #1
EXP_SaveR4     .BLKW #1
EXP_SaveR5     .BLKW #1
EXP_SaveR6     .BLKW #1
EXP_SAVER7	   .BLKW #1


	
	
;IN:R0, OUT:R5 (0-success, 1-fail/overflow)
;R3: STACK_END R4: STACK_TOP
;
PUSH	
	ST R3, PUSH_SaveR3	;save R3
	ST R4, PUSH_SaveR4	;save R4
	AND R5, R5, #0		;
	LD R3, STACK_END	;
	LD R4, STACk_TOP	;
	ADD R3, R3, #-1		;
	NOT R3, R3		;
	ADD R3, R3, #1		;
	ADD R3, R3, R4		;
	BRz OVERFLOW		;stack is full
	STR R0, R4, #0		;no overflow, store value in the stack
	ADD R4, R4, #-1		;move top of the stack
	ST R4, STACK_TOP	;store top of stack pointer
	BRnzp DONE_PUSH		;
OVERFLOW
	ADD R5, R5, #1		;
DONE_PUSH
	LD R3, PUSH_SaveR3	;
	LD R4, PUSH_SaveR4	;
	RET


PUSH_SaveR3	.BLKW #1	;
PUSH_SaveR4	.BLKW #1	;


;OUT: R0, OUT R5 (0-success, 1-fail/underflow)
;R3 STACK_START R4 STACK_TOP
;
POP	
	ST R3, POP_SaveR3	;save R3
	ST R4, POP_SaveR4	;save R3
	AND R5, R5, #0		;clear R5
	LD R3, STACK_START	;
	LD R4, STACK_TOP	;
	NOT R3, R3		;
	ADD R3, R3, #1		;
	ADD R3, R3, R4		;
	BRz UNDERFLOW		;
	ADD R4, R4, #1		;
	LDR R0, R4, #0		;
	ST R4, STACK_TOP	;
	BRnzp DONE_POP		;
UNDERFLOW
	ADD R5, R5, #1		;
DONE_POP
	LD R3, POP_SaveR3	;
	LD R4, POP_SaveR4	;
	RET


POP_SaveR3	.BLKW #1	;
POP_SaveR4	.BLKW #1	;


STACK_SIZE
;OUT: R5
	ST R3, SIZE_SaveR3	;save R3
	ST R4, SIZE_SaveR4	;save R3

    LD R3, STACK_START
    LD R4, STACk_TOP

	NOT R4, R4
    ADD R4, R4, #1
    ADD R4, R4, R3

	AND R5, R5, #0
	ADD R5, R4, #0

	LD R3, SIZE_SaveR3	;
	LD R4, SIZE_SaveR4	;
	RET



SIZE_SaveR3	.BLKW #1	;
SIZE_SaveR4	.BLKW #1	;


STACK_END	.FILL x3FF0	;
STACK_START	.FILL x4000	;
STACK_TOP	.FILL x4000	;


.END