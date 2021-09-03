.ORIG x3000
; Write code to read in characters and echo them
; till a newline character is entered.
LOOP
        GETC

        ; Check Newline
        LD R1, NEW_LINE
        NOT R1, R1
        ADD R1, R1, #1
        ADD R1, R0, R1
        BRz END


        ; Check '('
        LD R1, OPEN
        NOT R1, R1
        ADD R1, R1, #1
        ADD R1, R0, R1
        BRz CHECK_BALANCE

        ; Check ')'
        LD R1, CLOSE
        NOT R1, R1
        ADD R1, R1, #1
        ADD R1, R0, R1
        BRz CHECK_BALANCE
        BRnzp LOOP

CHECK_BALANCE
        OUT

        JSR IS_BALANCED
        AND R5, R5, R5

        BRp SET_UNBALANCE_FLAG
        BRnzp LOOP

SET_UNBALANCE_FLAG
        ADD R6, R5, #0
        BRnzp LOOP

END
        JSR IS_STACK_EMPTY

        NOT R6, R6
        NOT R5, R5
        AND R5, R5, R6
        NOT R5, R5

        HALT
 
SPACE   .FILL x0020
NEW_LINE        .FILL x000A
CHAR_RETURN     .FILL x000D
OPEN    .FILL x0028
CLOSE   .FILL x0029
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if ( push onto stack if ) pop from stack and check if popped value is (
;input - R0 holds the input
;output - R5 set to -1 if unbalanced. else 1.
IS_BALANCED
        ST R0, IS_BALANCED_SAVER0
        ST R1, IS_BALANCED_SAVER1
        ST R7, IS_BALANCED_SAVER7


        LD R1, NEG_OPEN
        ADD R1, R0, R1
        BRz IS_BALANCED_PUSH
        BRnzp IS_BALANCED_POP

IS_BALANCED_PUSH
        JSR PUSH
        BRnzp IS_BALANCED_IF_ELSE_END

IS_BALANCED_POP
        JSR POP
        BRz IS_BALANCED_IF_ELSE_END

IS_BALANCED_IF_ELSE_END
        LD R0, IS_BALANCED_SAVER0
        LD R1, IS_BALANCED_SAVER1
        LD R7, IS_BALANCED_SAVER7
        RET

NEG_OPEN .FILL xFFD8
IS_BALANCED_SaveR0 .BLKW #1
IS_BALANCED_SaveR1 .BLKW #1
IS_BALANCED_SaveR7 .BLKW #1


; OUT:R5 (0-empty, 1-not empty)
IS_STACK_EMPTY
        ST R3, IS_STACK_EMPTY_SaveR3      ;save R3
        ST R4, IS_STACK_EMPTY_SaveR4      ;save R4

        AND R5, R5, #0

        LD R3, STACK_START
        LD R4, STACk_TOP

        NOT R4, R4
        ADD R4, R4, #1
        ADD R4, R4, R3
        
        BRnp IS_STACK_EMPTY_RETURN_FALSE
        BRnzp IS_STACK_EMPTY_END

IS_STACK_EMPTY_RETURN_FALSE
        ADD R5, R5, #1


IS_STACK_EMPTY_END
        LD R3, IS_STACK_EMPTY_SaveR3      ;save R3
        LD R4, IS_STACK_EMPTY_SaveR4      ;save R4
        RET



IS_STACK_EMPTY_SaveR3     .BLKW #1        ;
IS_STACK_EMPTY_SaveR4     .BLKW #1        ;


;IN:R0, OUT:R5 (0-success, 1-fail/overflow)
;R3: STACK_END R4: STACK_TOP
;
PUSH
        ST R3, PUSH_SaveR3      ;save R3
        ST R4, PUSH_SaveR4      ;save R4
        AND R5, R5, #0          ;
        LD R3, STACK_END        ;
        LD R4, STACk_TOP        ;
        ADD R3, R3, #-1         ;
        NOT R3, R3              ;
        ADD R3, R3, #1          ;
        ADD R3, R3, R4          ;
        BRz OVERFLOW            ;stack is full
        STR R0, R4, #0          ;no overflow, store value in the stack
        ADD R4, R4, #-1         ;move top of the stack
        ST R4, STACK_TOP        ;store top of stack pointer
        BRnzp DONE_PUSH         ;
OVERFLOW
        ADD R5, R5, #1          ;
DONE_PUSH
        LD R3, PUSH_SaveR3      ;
        LD R4, PUSH_SaveR4      ;
        RET


PUSH_SaveR3     .BLKW #1        ;
PUSH_SaveR4     .BLKW #1        ;


;OUT: R0, OUT R5 (0-success, 1-fail/underflow)
;R3 STACK_START R4 STACK_TOP
;
POP
        ST R3, POP_SaveR3       ;save R3
        ST R4, POP_SaveR4       ;save R3
        AND R5, R5, #0          ;clear R5
        LD R3, STACK_START      ;
        LD R4, STACK_TOP        ;
        NOT R3, R3              ;
        ADD R3, R3, #1          ;
        ADD R3, R3, R4          ;
        BRz UNDERFLOW           ;
        ADD R4, R4, #1          ;
        LDR R0, R4, #0          ;
        ST R4, STACK_TOP        ;
        BRnzp DONE_POP          ;
UNDERFLOW
        ADD R5, R5, #1          ;
DONE_POP
        LD R3, POP_SaveR3       ;
        LD R4, POP_SaveR4       ;
        RET


POP_SaveR3      .BLKW #1        ;
POP_SaveR4      .BLKW #1        ;
STACK_END       .FILL x3FF0     ;
STACK_START     .FILL x4000     ;
STACK_TOP       .FILL x4000     ;

.END

