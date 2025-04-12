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
    mov ah, 6       
    mov al, 0       
    mov bh, 07h    
    mov ch, 0       
    mov cl, 0       
    mov dh, 24    
    mov dl, 79
    int 10h 
    call chosegameplay
    mov ah, 6       
    mov al, 0       
    mov bh, 07h    
    mov ch, 0       
    mov cl, 0       
    mov dh, 24    
    mov dl, 79
    int 10h 

    mov ah,4ch
    int 21h
    
    ret
main endp  
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
     cmp al, '1'
    je select_map1
    cmp al, '2'
    je select_map2
    cmp al, '3'
    je select_map3
    cmp al, '4'
    je select_map4
    jmp chosegameplay_end  
    select_map1:
        mov seclectmapindex, 1
        jmp chosegameplay_end
    
    select_map2:
        mov seclectmapindex, 2
        jmp chosegameplay_end
    
    select_map3:
        mov seclectmapindex, 3
        jmp chosegameplay_end
    
    select_map4:
        mov seclectmapindex, 4
        jmp chosegameplay_end 
endp
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
    
    jmp chosegameplay_end
    cmp al, '1'
    je 1select_map1
    cmp al, '2'
    je 1select_map2
    cmp al, '3'
    je 1select_map3
    cmp al, '4'
    je 1select_map4
    jmp chosegameplay_end  
    1select_map1:
        mov seclectmapindex, 1
        jmp chosegameplay_end
    
    1select_map2:
        mov seclectmapindex, 2
        jmp chosegameplay_end
    
    1select_map3:
        mov seclectmapindex, 3
        jmp chosegameplay_end
    
    1select_map4:
        mov seclectmapindex, 4
        jmp chosegameplay_end  
endp
chosegameplay proc
    mov ah, 6       
    mov al, 0       
    mov bh, 07h    
    mov ch, 0       
    mov cl, 0       
    mov dh, 24    
    mov dl, 79
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

    cmp al, '1'
    je call_gmpl1
    
    cmp al, '2'
    je call_gmpl2
    
    call_gmpl1:
        call gmpl1
        jmp chosegameplay_end
    
    call_gmpl2:
        call gmpl2
        jmp chosegameplay_end
 
    
     
    chosegameplay_end:
    ret
    
 
    

chosegameplay endp  
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