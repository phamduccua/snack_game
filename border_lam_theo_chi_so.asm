.model small
.stack 100h
.data
    index1 db 1,0,1,80,3,0,24,0,24,0,24,79,1,79,24,79
    index2 db 1,0,1,80,3,0,24,0,24,0,24,79,1,79,24,79,5,10,10,10,10,10,10,40,5,40,10,40,15,30,20,35
    index3 db 1,5,1,75,5,10,10,10,10,10,10,40,5,40,10,40,15,30,20,35,5,50,5,70,5,70,15,70,15,70,15,55,15,55,10,55,24,0,24,79,1,0,24,0,1,79,24,79,12,2,12,3,22,77,22,78
    index4 db 1,0,1,79,24,0,24,79,1,0,24,0,1,79,24,79,5,10,5,60,15,20,15,70,10,30,20,30,8,50,18,50,12,2,12,3,22,77,22,78,6,5,6,6,18,74,18,75
    count dw 4
.code
main proc
    mov ax, @data
    mov ds, ax
    call border3
    
    mov ah, 4Ch
    int 21h
main endp
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
border1 endp  

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
border2 endp
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
border3 endp
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
border4 endp

