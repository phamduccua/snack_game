.stack 100h

.data 
    index1 db 1,0,1,80,3,0,24,0,24,0,24,79,1,79,24,79
    index2 db 1,0,1,80,3,0,24,0,24,0,24,79,1,79,24,79,5,10,10,10,10,10,10,40,5,40,10,40,15,30,20,35
    index3 db 1,0,1,79,5,10,10,10,10,10,10,40,5,40,10,40,15,30,20,35,5,50,5,70,5,70,15,70,15,70,15,55,15,55,10,55,24,0,24,79,1,0,24,0,1,79,24,79,12,2,12,3,22,77,22,78
    index4 db 1,0,1,79,24,0,24,79,1,0,24,0,1,79,24,79,5,10,5,60,15,20,15,70,10,30,20,30,8,50,18,50,12,2,12,3,22,77,22,78,6,5,6,6,18,74,18,75
    count dw 4 

    s_size equ 3        
    snack 200 dup(0)    
    head_x equ 5         
    head_y equ 3         
    direction db 1
    gameOverMsg db 'GAME OVER!', 0Dh, 0Ah, '$'
    
    header db "Snake Game", 0
    main1  db "This game made by group 3", 0
    main2  db "For Posts and Telecommunications Institute of Technology", 0
    main3  db "Press any key to start", 0
    
    instructioN db "Instruction simple : ",0 
    uP1 db  "Up : ",0                       
    dowN1 db "Down : ",0                    
    righT1 db "Right : ",0
    lefT1 db "Left : ",0
    
    seclect db "Please choose gameplay :",0
    gameplay1 db "Freedom",0
    gameplay2 db "Challenge",0  
    
    seclect1 db "You choose gameplay freedom. Please choose map :",0
    m1 db "Map 1",0
    m2 db "Map 2",0
    m3 db "Map 3",0
    m4 db "Map 4",0
    seclect2 db "You choose gameplay challenge. Please choose map :",0
    seclectmapindex db 0
    
;0 la canh bao ket thuc chuoi
.code
main proc
    mov ax, @data
    mov ds, ax
    mov ax, 0b800h
    ;0b800h la dia chi segment cua vung nho video
    mov es, ax
    ;es cung cap cac doan bo sung cho viec luu du lieu
    call main_menu 
    
    ;cho nguoi dung an nut de tiep tuc
    mov ah, 0
    int 16h
   
    
    call instruction1 
    mov ah, 0
    int 16h
    
    call chosegameplay
    mov ah, 6       
    mov al, 0       
    mov bh, 07h    
    mov ch, 0       
    mov cl, 0       
    mov dh, 24    
    mov dl, 79
    int 10h 
    call start
    mov ah,4ch
    int 21h
    
    ret
main endp  
chosegameplay proc
    mov ah, 6       
    mov al, 0       
    mov bh, 07h    
    mov ch, 0       
    mov cl, 0       
    mov dh, 24    
    mov dl, 79
    int 10h 
    
    call border1    
    lea si, seclect
    mov di, 160 * 3 + 30 * 2
    call print_string 
    
    lea si, gameplay1
    mov di, 160 * 7 + 30 * 2
    call print_string 
    
    lea si, gameplay2
    mov di, 160 * 9 + 30 * 2
    call print_string
    
    
    mov ah, 0
    int 16h
    
    cmp al,'1'
    je gmpl1
    
   
chosegameplay endp 
gmpl1 proc
    mov ah, 6       
    mov al, 0       
    mov bh, 07h    
    mov ch, 0       
    mov cl, 0       
    mov dh, 24    
    mov dl, 79
    int 10h 
    
    call border1
    lea si, seclect1
    mov di, 160 * 3 + 30 * 2
    call print_string 
    
    lea si, m1
    mov di, 160 * 5 + 30 * 2
    call print_string

    lea si, m2
    mov di, 160 * 7 + 30 * 2
    call print_string 

    lea si, m3
    mov di, 160 * 9 + 30 * 2
    call print_string
                       
    lea si, m4
    mov di, 160 * 11 + 30 * 2
    call print_string 
    
    mov ah, 0
    int 16h
    
    cmp al,1
    je hinh1
    hinh1:
        call border3 
        lea si,index3
        mov cx,56/4
        
gmpl1 endp

gmpl2 proc
    mov ah, 6       
    mov al, 0       
    mov bh, 07h    
    mov ch, 0       
    mov cl, 0       
    mov dh, 24    
    mov dl, 79
    int 10h 
    
    call border1
    lea si, seclect2
    mov di, 160 * 3 + 30 * 2
    call print_string 
    
    lea si, m1
    mov di, 160 * 5 + 30 * 2
    call print_string

    lea si, m2
    mov di, 160 * 7 + 30 * 2
    call print_string 

    lea si, m3
    mov di, 160 * 9 + 30 * 2
    call print_string
                       
    lea si, m4
    mov di, 160 * 11 + 30 * 2
    call print_string 
    
    mov ah, 0
    int 16h
gmpl2 endp
    

instruction1 proc 
    mov ah, 6       
    mov al, 0       
    mov bh, 07h    
    mov ch, 0       
    mov cl, 0       
    mov dh, 24    
    mov dl, 79
    int 10h 
    
    call border1
    
    lea si, instructioN
    mov di, 160 * 3 + 30 * 2
    call print_string 
    
    lea si, uP1
    mov di, 160 * 5 + 30 * 2
    call print_string
    
    mov al, 24
    mov ah, 0Fh      
    mov word ptr es:[di], ax
                
    lea si, dowN1
    mov di, 160 * 7 + 30 * 2
    call print_string 
    
    mov al, 25
    mov ah, 0Fh      
    mov word ptr es:[di], ax

    lea si, lefT1
    mov di, 160 * 9 + 30 * 2
    call print_string
    
    mov al, 27
    mov ah, 0Fh      
    mov word ptr es:[di], ax
                  
    lea si, righT1
    mov di, 160 * 11 + 30 * 2
    call print_string
    
    mov al, 26
    mov ah, 0Fh      
    mov word ptr es:[di], ax
    
    

    ret
    
instruction1 endp
;che do dia chi segment moi ki tu chu 2 byte 1 byte luu ma assci 1 byte luu ma mau                                   
;moi dong co 80 cot *2 byte = 160 byte 
;moi ky tu chua 2 byte den di den dung vi tri cot thi ta can nhay den cot*2
;cach tinh vi tri (row*160)+(col*2)
main_menu proc
    mov ah, 6       
    mov al, 0       
    mov bh, 07h    
    mov ch, 0       
    mov cl, 0       
    mov dh, 24    
    mov dl, 79
    int 10h 
     
    call border1
    
    lea si, header
    mov di, 160 * 5 + 30 * 2
    call print_string

   
    lea si, main1
    mov di, 160 * 7 + 25 * 2
    call print_string

    lea si, main2
    mov di, 160 * 9 + 10 * 2
    call print_string

    lea si, main3
    mov di, 160 * 11 + 28 * 2
    call print_string

    ret
main_menu endp
;lodsb :
;nap chuoi nguon byte vao thanh ghi al
;al=[si],si++(df=0)
print_string proc
next_char:
    lodsb            
    cmp al, 0
    je done
    ;es tro vao vung nho
    ;suy ra trong es co 2 bit
    mov es:[di], al  ;ghi ki tu vao man hinh 
    mov es:[di+1], 0Ah;hien thi mau sac cua ki tu
    add di, 2
    jmp next_char
done:
    ret
print_string endp
start proc
    call border3
    mov [snack], head_x
    mov [snack+1], head_y
    mov [snack+2], 4
    mov [snack+3], 3
    mov [snack+4], 3
    mov [snack+5], 3      
start endp
mainLoop proc
    
    call eraseOldTail  
    call moveSnack 
     
    call drawSnack  
    call readKey          
    call checkWallCollision    
    jmp mainLoop
mainLoop endp
readKey proc
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
readKey endp
checkNormalKey proc
    cmp al, 1Bh   
    je exitProgram
    doneReadKey:
    ret
checkNormalKey endp
exitProgram proc
    mov ax, 4C00h
    int 21h
exitProgram endp
moveRight proc
    cmp direction, 3
    je conitnue
    mov direction, 1  
    ret      
moveRight endp
moveDown proc 
    cmp direction, 4
    je  conitnue
    mov direction, 2
    ret      
moveDown endp
moveLeft proc
    cmp direction, 1
    je conitnue
    mov direction, 3
    ret      
moveLeft endp
moveUp proc
    cmp direction, 2
    je conitnue
    mov direction, 4
    ret    
moveUp endp
conitnue proc
    ret
conitnue endp
moveSnack proc    
    mov si, s_size * 2 - 2
moveSnack endp      
moveBody proc   
    cmp si, 1 
    jl doneMove
    mov al, [snack + si - 2]  
    mov [snack + si], al      
    mov al, [snack + si - 1]   
    mov [snack + si + 1], al   
    sub si, 2
    jmp moveBody
moveBody endp        
doneMove proc 
    cmp direction, 1
    je moveRightHead
    cmp direction, 2
    je moveDownHead
    cmp direction, 3
    je moveLeftHead
    cmp direction, 4
    je moveUpHead
    ret
doneMove endp
moveRightHead proc
    inc byte ptr [snack]
    ret           
moveRightHead endp
moveDownHead proc
    inc byte ptr [snack+1]
    ret          
moveDownHead endp
moveLeftHead proc
    dec byte ptr [snack]
    ret          
moveLeftHead endp
moveUpHead proc
    dec byte ptr [snack+1]
    ret        
moveUpHead endp

eraseOldTail proc
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
eraseOldTail endp
drawSnack proc  
    mov si, s_size * 2
drawSnack endp
drawBody proc
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
drawBody endp
drawHead proc 
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
drawHead endp 
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
checkWallCollision proc
    mov al, [snack]        
    mov bl, [snack+1]     

          

checkLoop:
    mov dh, [si]           
    mov dl, [si+1]        
    mov ah, [si+2]        
    mov bh, [si+3]         

    
    cmp bl, dh
    jb nextBlock
    cmp bl, ah
    ja nextBlock

    cmp al, dl
    jb nextBlock
    cmp al, bh
    ja nextBlock

    call game_over
    ret

nextBlock:
    add si, 4
    loop checkLoop
    ret
checkWallCollision endp

game_over proc
    mov ah, 02h          
    mov bh, 0
    mov dh, 12          
    mov dl, 30           
    int 10h

    mov ah, 09h          
    lea dx, gameOverMsg
    int 21h

    mov ah, 4Ch         
    int 21h   
game_over endp

