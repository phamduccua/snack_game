.model small
.stack 100h
.data
    index1 db 1,0,1,80,3,0,24,0,24,0,24,79,1,79,24,79
    index2 db 1,0,1,80,3,0,24,0,24,0,24,79,1,79,24,79,5,10,10,10,10,10,10,40,5,40,10,40,15,30,20,35
    index3 db 1,5,1,75,5,10,10,10,10,10,10,40,5,40,10,40,15,30,20,35,5,50,5,70,5,70,15,70,15,70,15,55,15,55,10,55,24,0,24,79,1,0,24,0,1,79,24,79,12,2,12,3,22,77,22,78
    index4 db 1,0,1,79,24,0,24,79,1,0,24,0,1,79,24,79,5,10,5,60,15,20,15,70,10,30,20,30,8,50,18,50,12,2,12,3,22,77,22,78,6,5,6,6,18,74,18,75
    count dw 4
    s_size equ 3        
    snack 200 dup(0)    
    head_x equ 5         
    head_y equ 3         
    direction db 1       
.code
start:
    mov ax, @data
    mov ds, ax 
    call border3 
    mov [snack], head_x
    mov [snack+1], head_y
    mov [snack+2], 4
    mov [snack+3], 3
    mov [snack+4], 3
    mov [snack+5], 3      

mainLoop:
    
    call eraseOldTail  
    call moveSnack  
    call drawSnack  
    call readKey  
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
    cmp direction, 3
    je conitnue
    mov direction, 1  
    ret
moveDown: 
    cmp direction, 4
    je  conitnue
    mov direction, 2
    ret
moveLeft:
    cmp direction, 1
    je conitnue
    mov direction, 3
    ret
moveUp:
    cmp direction, 2
    je conitnue
    mov direction, 4
    ret
conitnue:
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

eraseOldTail:
    mov ah, 02h
    mov bh, 0
    mov dh, [snack + (s_size * 2) - 1]  
    mov dl, [snack + (s_size * 2) - 2]  
    int 10h
    mov ah, 09h
    mov al, ' '
    mov bl, 0FH
    mov cx, 1
    int 10h
    ret

drawSnack:  
    mov si, s_size * 2

drawBody:
    cmp si, 2
    jl drawHead
    mov ah, 02h
    mov bh, 0
    mov dh, [snack + si - 1]
    mov dl, [snack + si - 2]
    int 10h
    mov ah, 09h
    mov al, '*'
    mov bl, 0FH
    mov cx, 1
    int 10h
    sub si, 2
    jmp drawBody

drawHead:
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
    ret 
;call border
border1 proc
    mov ah, 0
    mov al, 3
    int 10h

    lea si, index1
    draw_walls:
        mov ch, [si]      
        mov cl, [si+1]    
        mov dh, [si+2]    
        mov dl, [si+3]    
        add si, 4            
        mov ah, 6        
        mov al, 0         
        mov bh, 0FFh      
        int 10h            
        cmp si,17
        jl draw_walls
ret  
endp
border2 proc
    mov ah, 0
    mov al, 3
    int 10h

    lea si, index2
    draw_walls1:
        mov ch, [si]      
        mov cl, [si+1]    
        mov dh, [si+2]    
        mov dl, [si+3]    
        add si, 4            
        mov ah, 6        
        mov al, 0         
        mov bh, 0FFh      
        int 10h            
        cmp si,48
        jl draw_walls1
ret
endp
border3 proc
    mov ah, 0
    mov al, 3
    int 10h

    lea si, index3
    draw_walls2:
        mov ch, [si]      
        mov cl, [si+1]    
        mov dh, [si+2]    
        mov dl, [si+3]    
        add si, 4            
        mov ah, 6        
        mov al, 0         
        mov bh, 0FFh      
        int 10h            
        cmp si,104
        jl draw_walls2
ret
endp
border4 proc
    mov ah, 0
    mov al, 3
    int 10h

    lea si, index4
    draw_walls3:
        mov ch, [si]      
        mov cl, [si+1]    
        mov dh, [si+2]    
        mov dl, [si+3]    
        add si, 4            
        mov ah, 6        
        mov al, 0         
        mov bh, 0FFh      
        int 10h            
        cmp si,151
        jl draw_walls3
ret
endp
end start
