.model small
.stack 100h
.data
    s_size equ 3
    snack s_size dup(0)
.code
start:
    mov ax, @data
    mov ds, ax

mainLoop:
    mov cx, s_size
    call drawSnack
    jmp mainLoop  
    
drawSnack:
    mov ah, 0Eh     
    mov al, '*'    
    int 10h         
    loop drawSnack  

    mov ah, 4Ch     
    int 21h
