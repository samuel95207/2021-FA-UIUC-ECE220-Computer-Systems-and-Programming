.ORIG x3000
; write your code here



    LD  R3, NUM
    JSR PRINT_NUMBER

    BRnzp DONE

; Function PRINT_NUMBER
; Registers:
;   R3: input
;   R4: digitCounter
;   R5: digit
;   R6: bitCounter
;   R0: tmp
PRINT_NUMBER
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


DONE
    halt

ZERO        .FILL x0000
NUM         .FILL x0A3F
ASCII_ZERO  .FILL x0030
ASCII_A_CAP .FILL x0041

R0_SAVE     .FILL 0
R1_SAVE     .FILL 0
R2_SAVE     .FILL 0
R3_SAVE     .FILL 0
R4_SAVE     .FILL 0
R5_SAVE     .FILL 0
R6_SAVE     .FILL 0
R7_SAVE     .FILL 0




.END