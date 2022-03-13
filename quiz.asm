data segment  
    menu db 0dh,0dh,09h,09h,09h,09h,"HANS QUIZ","$" 
                           
    q1 db 0ah,0dh,"How to delete an empty directory in linux?" ,"$"
    a1 db 0ah,0dh,"1.remove",0ah,0dh,"2.ls",0ah,0dh,"3.delete",0ah,0dh,"4.rmdir",0ah,0ah,"$"  
    q2 db 0ah,0dh,"Which of the following is a command in Linux?" ,"$"
    a2 db 0ah,0dh,"1.t",0ah,0dh,"2.w",0ah,0dh,"3.x",0ah,0dh,"4.All of the above",0ah,0ah,"$"
    q3 db 0ah,0dh,"When looking for all the processes running on a Linux system, what command should you use?","$"
    a3 db 0ah,0dh,"1.ps",0ah,0dh,"2.service",0ah,0dh,"3.oterm",0ah,0dh,"4.xrun",0ah,0ah,"$"
    q4 db 0ah,0dh,"Which of the following is a text editor that can be used in command mode to edit files on a Linux system?","$"
    a4 db 0ah,0dh,"1.open",0ah,0dh,"2.vi or vim",0ah,0dh,"3.lsof",0ah,0dh,"4.edit",0ah,0ah,"$"
    q5 db 0ah,0dh,"Which command is used to create file archives in Linux?","$"  
    a5 db 0ah,0dh,"1.ps",0ah,0dh,"2.arc",0ah,0dh,"3.zip",0ah,0dh,"4.tar",0ah,0ah,"$"  
    q6 db 0ah,0dh,"Which command is used to list contents of directories in Linux?","$"  
    a6 db 0ah,0dh,"1.tar",0ah,0dh,"2.dir",0ah,0dh,"3.lp",0ah,0dh,"4.ls",0ah,0ah,"$"   
    q7 db 0ah,0dh,"Software licensing that allows for modifications in all cases is called?","$"  
    a7 db 0ah,0dh,"1.freeware",0ah,0dh,"2.shareware",0ah,0dh,"3.open source",0ah,0dh,"4.closed source",0ah,0ah,"$" 
    q8 db 0ah,0dh,"Which of the following command would not be found in an assembly language?","$"  
    a8 db 0ah,0dh,"1.STORE",0ah,0dh,"2.SORT",0ah,0dh,"3.ADD",0ah,0dh,"4.LOAD",0ah,0ah,"$" 
    q9 db 0ah,0dh,"Which of the following is not a programming language?","$"  
    a9 db 0ah,0dh,"1.Typescript",0ah,0dh,"2.Anaconda",0ah,0dh,"3.Dart",0ah,0dh,"4.Rust",0ah,0ah,"$" 
    
    invalidOpt db 0ah,0dh,"Invalid Option !!!$"                 
    enter db 0ah,0dh,"Enter your answer : $"
    crrct db 0ah,0ah,0dh,"Your Answer is correct $"
    wrong db 0ah,0ah,0dh,"Your Answer is wrong $"
    correctAns db 0ah,0dh,"Correct Answer is : $"  
    cong db 0ah,0ah,0ah,0ah,0ah,0ah,09h,09h,09h,"Congrats! your score is ","$"    
    outof db "/9$"
    nl db 0ah,0dh,"$"    
    ans db 34h,32h,31h,32h,34h,34h,33h,32h,32h
    count db 00h
    countdf db 01h   
    timer_delay db ?
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

displayCrctAns macro
    mov ah,09h
    lea dx,correctAns
    int 21h
    
    mov ah,02h
    mov dl,bl
    int 21h
endm

code segment         
    assume cs:code ,ds:data
    start:   
    mov ax,data
    mov ds,ax    
     
    
    lea si,ans   
    insertquiz a9
    insertquiz q9 
    insertquiz a8
    insertquiz q8    
    insertquiz a7
    insertquiz q7 
    insertquiz a6
    insertquiz q6    
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
    clear
     
    
    mov cl,00h
    loop1: 
      mov bx,[si] 
      display menu
      display nl        
      displayqs  
      displayqs  
      display enter 
      call checkans
      inc si
      cmp bp,sp   
      jne loop1 
    
    display cong  
    add cl,30h  
    output cl 
    display outof
    mov ah,4ch   
    int 21h     
    checkans proc
     mov timer_delay,06h 
     input           
     call timer
     mov timer_delay,20h 
     cmp al,31h
     jc invalid
     cmp al,35h
     jnc invalid
     cmp al,bl
     jz harp:
     display wrong
     displayCrctAns 
     jmp back
     ret
     harp:
     display crrct 
     inc cl  
     jmp back
     ret  
     invalid:
     display invalidOpt
     displayCrctAns
     back:
     call timer
     clear
    endp
    timer proc 
       mov bh,00h
       mov ch,timer_delay
       big:    
       inc bh
       cmp bh,ch    
       jnz big  
      ret
     endp
    
code ends
end start