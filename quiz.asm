data segment  
    menu db "QUIZ",0ah,0dh,"1.default quiz",0ah,0dh,"2.custom quiz", "$" 
    
    q1 db 0ah,0dh,"How to delete a directory in linux?" ,"$"
    a1 db 0ah,0dh,"1.remove",0ah,0dh,"2.ls",0ah,0dh,"3.delete",0ah,0dh,"4.rmdir",0ah,0ah,"$"  
    q2 db 0ah,0dh,"Which of the following is a command in Linux?" ,"$"
    a2 db 0ah,0dh,"1.t",0ah,0dh,"2.w",0ah,0dh,"3.x",0ah,0dh,"4.All of the above",0ah,0ah,"$"
    q3 db 0ah,0dh,"When looking for all the processes running on a Linux system, what command should you use?","$"
    a3 db 0ah,0dh,"1.ps",0ah,0dh,"2.service",0ah,0dh,"3.oterm",0ah,0dh,"4.xrun",0ah,0ah,"$"
    q4 db 0ah,0dh,"Which of the following is a text editor that can be used in command mode to edit files on a Linux system?","$"
    a4 db 0ah,0dh,"1.open",0ah,0dh,"2.vi or vim",0ah,0dh,"3.lsof",0ah,0dh,"4.edit",0ah,0ah,"$"
    q5 db 0ah,0dh,"Which command is used to create file archives in Linux?","$"
    a5 db 0ah,0dh,"1.ps",0ah,0dh,"2.arc",0ah,0dh,"3.zip",0ah,0dh,"4.tar",0ah,0ah,"$" 
    crrct db 0ah,0dh,"Your Answer is correct ","$"
    wrong db 0ah,0dh,"Your Answer is wrong ","$"  
    cong db 0ah,0dh,"Congrats your score :","$"
    nl db 0ah,0dh,"$"    
    ans db 33h,32h,31h,32h,34h  
    count db 00h
    countdf db 01h  
    prevq dw 0ffh dup(?)
    preva dw 0ffh dup(?)
data ends 
display macro arg
    mov ah,09h
    lea dx,arg
    int 21h
endm       

input macro 
    mov ah,01h
    int 21h
endm   
output macro arg
    mov dl,arg
    mov ah,02h
    int 21h
endm
clear macro
    mov ax,03h
    int 10h
endm     
insertquiz macro arg
    lea ax,arg
    push ax
endm

displayqs macro
    mov ah,09h
    pop dx
    int 21h
endm

code segment         
    assume cs:code ,ds:data
    start:   
    mov ax,data
    mov ds,ax    
    
    lea si,ans    
    insertquiz a5
    insertquiz q5 
    insertquiz a4
    insertquiz q4
    insertquiz a3
    insertquiz q3
    insertquiz a2
    insertquiz q2
    insertquiz a1
    insertquiz q1
    mov cl,00h
    loop1: 
      mov bx,[si]
      display nl         
      displayqs  
      displayqs  
      display nl 
      call checkans
      inc si
      cmp bp,sp   
      jne loop1 
    
    display cong 
    add cl,30h  
    output cl
    mov ah,4ch
    int 21h
    checkans proc  
     input 
     cmp al,bl
     jz harp: 
     display wrong 
     call timer
     clear
     ret
     harp:
     display crrct 
     call timer 
     clear
     inc cl  
     ret
    endp
    timer proc 
       mov bh,00h
       mov ch,22h
       big:    
       inc bh
       cmp bh,ch    
       jnz big  
      ret
     endp
    
code ends
end start
