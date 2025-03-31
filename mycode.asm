.model small
.stack 100h
.data
    s_size equ 3        
    snack 200 dup(0)    
    head_x equ 5         
    head_y equ 3         
    direction db 1          
.code
start:
    mov ax, @data
    mov ds, ax
    mov [snack], head_x
    mov [snack+1], head_y
    mov [snack+2], 4
    mov [snack+3], 3
    mov [snack+4], 3
    mov [snack+5], 3      

mainLoop:
    call eraseOldSnack
        
    
    call readKey  
    call moveSnack      
    call drawSnack      
    jmp mainLoop

readKey:
    mov ah, 01h   
    int 16h
    jz doneReadKey  

    mov ah, 00h
    int 16h

    cmp al, 00h   
    jne checkNormalKey

    cmp ah, 48h   
    je moveUp
    cmp ah, 50h   
    je moveDown
    cmp ah, 4Bh   
    je moveLeft
    cmp ah, 4Dh   
    je moveRight
    ret

checkNormalKey:
    cmp al, 1Bh   
    je exitProgram
doneReadKey:
    ret

exitProgram:
    mov ax, 4C00h
    int 21h

moveRight:
    mov direction, 1  
    ret
moveDown:
    mov direction, 2
    ret
moveLeft:
    mov direction, 3
    ret
moveUp:
    mov direction, 4
    ret

moveSnack:    
    mov si, s_size * 2 - 2  
moveBody:   
    cmp si, 1 
    jl doneMove
    mov al, [snack + si - 2]  
    mov [snack + si], al      
    mov al, [snack + si - 1]   
    mov [snack + si + 1], al   
    sub si, 2
    jmp moveBody
        
doneMove: 
    cmp direction, 1
    je moveRightHead
    cmp direction, 2
    je moveDownHead
    cmp direction, 3
    je moveLeftHead
    cmp direction, 4
    je moveUpHead
    ret

moveRightHead:
    inc byte ptr [snack]
    ret
moveDownHead:
    inc byte ptr [snack+1]
    ret
moveLeftHead:
    dec byte ptr [snack]
    ret
moveUpHead:
    dec byte ptr [snack+1]
    ret

eraseOldSnack:
    mov ah, 02h
    mov bh, 0
    mov dh, [snack+1]
    mov dl, [snack]
    int 10h
    mov ah, 09h
    mov al, ' '
    mov bl, 0FH
    mov cx, 1
    int 10h

    mov si, 2
eraseBody:
    cmp si, s_size * 2
    jge doneErase
    mov ah, 02h
    mov bh, 0
    mov dh, [snack + si + 1]
    mov dl, [snack + si]
    int 10h
    mov ah, 09h
    mov al, ' '
    mov bl, 0FH
    mov cx, 1
    int 10h
    add si, 2
    jmp eraseBody
doneErase:
    ret

drawSnack:  
    mov ah, 02h
    mov bh, 0
    mov dh, [snack+1]
    mov dl, [snack]
    int 10h
    mov ah, 09h
    mov al, 'O'
    mov bl, 0FH
    mov cx, 1
    int 10h

    mov si, 2
drawBody:
    cmp si, s_size * 2
    jge doneDraw
    mov ah, 02h
    mov bh, 0
    mov dh, [snack + si + 1]
    mov dl, [snack + si]
    int 10h
    mov ah, 09h
    mov al, '*'
    mov bl, 0FH
    mov cx, 1
    int 10h
    add si, 2
    jmp drawBody
    
doneDraw: 
    ret
end start
