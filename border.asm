.model small
.stack 100h  
.data
.code
main proc
    mov ax,@data
    mov ds,ax
    
    call border2
    mov ah,4ch
    int 21h
    
    
main endp
border1 proc
    
    ;thiet lap che do video  
    ;ah,0 : co che do video /byte che do dieu khien crt
    ;ah,3 : nhan dinh va dinh dang vi tri con tro ,
    ;ch= hang bat dau 
    ;cl= cot bat dau
    ;dh= hang ket thuc
    ;dl= cot ket thuc
    mov ah,0
    mov al,3 ;che do van ban 80*25,16 mau tieu chuan VGA
    int 10h
    
    ;ah=6 dung de xoa vung man hinh de tao ra bang hoac cuon len
    ;al=0 chon cai xoa vung man hinh
    ;al= so dong can su dung (0=xoa ,ch,cl,dh,dl duoc su dung)
    ;bh la mau nen  
    mov ah,6
    mov al,0 
    mov bh,0ffh 
    
    mov ch,1
    mov cl,0
    mov dh,1
    mov dl,80
    int 10h 
  
    mov ch,3
    mov cl,0
    mov dh,24
    mov dl,0
    int 10h
   
    mov ch,24
    mov cl,0
    mov dh,24
    mov dl,79
    int 10h
    
    mov ch,1
    mov cl,79
    mov dh,24
    mov dl,79
    int 10h

ret
endp 
border2 proc 
    mov ah,0
    mov al,3
    int 10h
    
    mov ah,6
    mov al,0 
    mov bh,0FFh 
       
    mov ch,1
    mov cl,0
    mov dh,1
    mov dl,80
    int 10h 

    mov ch,5
    mov cl,10
    mov dh,10
    mov dl,10
    int 10h

    mov ch,10
    mov cl,10
    mov dh,10
    mov dl,40
    int 10h 

    mov ch,5
    mov cl,40
    mov dh,10
    mov dl,40
    int 10h 

    mov ch,15
    mov cl,30
    mov dh,20
    mov dl,35
    int 10h 
    
    mov ch,24
    mov cl,0
    mov dh,24
    mov dl,79
    int 10h
    
    mov ch,1
    mov cl,0
    mov dh,24
    mov dl,0
    int 10h

    mov ch,1
    mov cl,79
    mov dh,24
    mov dl,79
    int 10h

ret
endp
border3 proc 
    mov ah,0
    mov al,3
    int 10h
    
    mov ah,6
    mov al,0 
    mov bh,0FFh 
    
   
    mov ch,1
    mov cl,5
    mov dh,1
    mov dl,75
    int 10h 

    
    mov ch,5
    mov cl,10
    mov dh,10
    mov dl,10
    int 10h

    mov ch,10
    mov cl,10
    mov dh,10
    mov dl,40
    int 10h 

    mov ch,5
    mov cl,40
    mov dh,10
    mov dl,40
    int 10h 

    
    mov ch,15
    mov cl,30
    mov dh,20
    mov dl,35
    int 10h 

    
    mov ch,5
    mov cl,50
    mov dh,5
    mov dl,70
    int 10h 

    mov ch,5
    mov cl,70
    mov dh,15
    mov dl,70
    int 10h 

    mov ch,15
    mov cl,70
    mov dh,15
    mov dl,55
    int 10h 

    mov ch,15
    mov cl,55
    mov dh,10
    mov dl,55
    int 10h 
  
    mov ch,24
    mov cl,0
    mov dh,24
    mov dl,79
    int 10h
    
    
    mov ch,1
    mov cl,0
    mov dh,24
    mov dl,0
    int 10h

    mov ch,1
    mov cl,79
    mov dh,24
    mov dl,79
    int 10h  
    
    ;doan nay can xu li teleport
    mov ch,12
    mov cl,2
    mov dh,12
    mov dl,3
    int 10h 

   
    mov ch,22
    mov cl,77
    mov dh,22
    mov dl,78
    int 10h 

ret
endp
border_hard proc
    mov ah,0
    mov al,3
    int 10h
    
    mov ah,6
    mov al,0 
    mov bh,0FFh 

    
    mov ch,1
    mov cl,0
    mov dh,1
    mov dl,79
    int 10h 

    mov ch,24
    mov cl,0
    mov dh,24
    mov dl,79
    int 10h
    
    mov ch,1
    mov cl,0
    mov dh,24
    mov dl,0
    int 10h

    mov ch,1
    mov cl,79
    mov dh,24
    mov dl,79
    int 10h

    mov ch,5
    mov cl,10
    mov dh,5
    mov dl,60
    int 10h 

    mov ch,15
    mov cl,20
    mov dh,15
    mov dl,70
    int 10h 

    mov ch,10
    mov cl,30
    mov dh,20
    mov dl,30
    int 10h 

    mov ch,8
    mov cl,50
    mov dh,18
    mov dl,50
    int 10h 

    mov ch,12
    mov cl,2
    mov dh,12
    mov dl,3
    int 10h 

    mov ch,22
    mov cl,77
    mov dh,22
    mov dl,78
    int 10h  
    
    ;cho nay can xu li teleport
    mov ch,6
    mov cl,5
    mov dh,6
    mov dl,6
    int 10h 

    mov ch,18
    mov cl,74
    mov dh,18
    mov dl,75
    int 10h 

ret
endp
