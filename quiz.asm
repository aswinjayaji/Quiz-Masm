data segment 
    q1 db 0ah,0dh,"How to delete a directory in linux?" ,"$"
    a1 db 0ah,0dh,"1.remove",0ah,0dh,"2.ls",0ah,0dh,"3.delete",0ah,0dh,"4.rmdir",0ah,0ah,"5.prev 6.next","$"  
    q2 db 0ah,0dh,"Which of the following is a command in Linux?" ,"$"
    a2 db 0ah,0dh,"1.t",0ah,0dh,"2.w",0ah,0dh,"3.x",0ah,0dh,"4.All of the above",0ah,0ah,"5.prev 6.next","$"
    q3 db 0ah,0dh,"When looking for all the processes running on a Linux system, what command should you use?","$"
    a3 db 0ah,0dh,"1.ps",0ah,0dh,"2.service",0ah,0dh,"3.oterm",0ah,0dh,"4.xrun",0ah,0ah,"5.prev 6.next","$"
    q4 db 0ah,0dh,"Which of the following is a text editor that can be used in command mode to edit files on a Linux system?","$"
    a4 db 0ah,0dh,"1.open",0ah,0dh,"2.vi or vim",0ah,0dh,"3.lsof",0ah,0dh,"4.edit",0ah,0ah,"5.prev 6.next","$"
    q5 db 0ah,0dh,"Which command is used to create file archives in Linux?","$"
    a5 db 0ah,0dh,"1.ps",0ah,0dh,"2.arc",0ah,0dh,"3.zip",0ah,0dh,"4.tar",0ah,0ah,"5.prev 6.next","$"     
    cong db 0ah,0dh,"Congrats your score :","$"
    nl db 0ah,0dh,"$"    
    ans db 31h,32h,33h,34h,32h  
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
    lea si,ans
    loop1:
      display nl         
      displayqs  
      mov prevq,dx
      displayqs 
      mov preva,dx
      display nl
      input
      mov bl,al 
      clear
      cmp bx,35h
      jnz next 
       mov ax,preva
       push ax
       mov ax,prevq
       push ax
      next: 
      cmp bx,[si]
      jnz next2     
      mov cl,0h
      call countinc
      next2:
      cmp bp,sp   
      jne loop1 
      
    countinc proc
        mov cl,count   
        inc cl
        mov count,cl
        
        ret
    endp   
    mov count,dl
    mov ah,02
    int 21h
    mov ah,4ch
    int 21h
code ends
end start