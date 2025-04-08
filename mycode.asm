ORG 100h  ; Ch?y ? ch? d? .COM

; ========== BI?N TO�N C?C ==========
FOOD_X       DB 0       ; To? d? X (c?t)
FOOD_Y       DB 0       ; To? d? Y (h�ng)
FOOD_ICON    DB 0       ; K� t? d?i di?n cho th?c an
FOOD_COLOR   DB 0       ; M�u s?c

; ========== CODE B?T �?U ==========
START:
    ; Chuy?n v? ch? d? van b?n 80x25
    MOV AX, 03h
    INT 10h

    CALL GENERATE_RANDOM_FOOD
    CALL DISPLAY_FOOD

    ; Ch? ngu?i d�ng nh?n ph�m
    MOV AH, 0
    INT 16h

    INT 20h  ; K?t th�c chuong tr�nh

; ========== T?O TH?C AN NG?U NHI�N ==========
GENERATE_RANDOM_FOOD PROC
    ; L?y th?i gian h? th?ng l�m seed
    MOV AH, 00h
    INT 1Ah         ; DL = count of clock ticks
    MOV AL, DL      ; AL = seed

    ; T�nh ng?u nhi�n X: 0�79
    MOV AH, 0
    MOV BL, 80
    DIV BL
    MOV FOOD_X, AH

    ; T�nh ng?u nhi�n Y: 0�24
    MOV AL, DL
    MOV AH, 0
    MOV BL, 25
    DIV BL
    MOV FOOD_Y, AH

    ; T�nh ng?u nhi�n lo?i th?c an d?a tr�n DL
    MOV AL, DL
    CMP AL, 25
    JLE SET_DIAMOND

    CMP AL, 55
    JLE SET_GOLD

    ; M?c d?nh: B?c (60%)
    MOV FOOD_ICON, 127    ; H�nh tam gi�c ho?c d?c bi?t
    MOV FOOD_COLOR, 8     ; M�u x�m (b?c)
    RET

SET_GOLD:
    MOV FOOD_ICON, 254    ; H�nh thoi (�)
    MOV FOOD_COLOR, 14    ; M�u v�ng
    RET

SET_DIAMOND:
    MOV FOOD_ICON, 4      ; Bi?u tu?ng kim cuong (?)
    MOV FOOD_COLOR, 15    ; Tr?ng s�ng
    RET
GENERATE_RANDOM_FOOD ENDP

; ========== HI?N TH? TH?C AN ==========
DISPLAY_FOOD PROC
    ; �?t con tr? t?i v? tr� (Y, X)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, FOOD_Y
    MOV DL, FOOD_X
    INT 10h

    ; In k� t?
    MOV AH, 09h
    MOV AL, FOOD_ICON
    MOV BL, FOOD_COLOR
    MOV CX, 1
    INT 10h
    RET
DISPLAY_FOOD ENDP

END START
Footer
� 2025 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
S