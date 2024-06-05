.MODEL small
.STACK 100h

.DATA
;homescreen
homescreen1 db 13,10,'          ____    _    _   _  ___  _   _    ____    _    __  __ _____ $'
homescreen2 db 13,10,'         / ___|  / \  | \ | |/ _ \| \ | |  / ___|  / \  |  \/  | ____|$'
homescreen3 db 13,10,'        | |     / _ \ |  \| | | | |  \| | | |  _  / _ \ | |\/| |  _|  $'
homescreen4 db 13,10,'        | |___ / ___ \| |\  | |_| | |\  | | |_| |/ ___ \| |  | | |___ $'
homescreen5 db 13,10,'         \____/_/   \_\_| \_|\___/|_| \_|  \____/_/   \_\_|  |_|_____|$' 

namepresentation db 13,10,'                                by Oz Yehezkel                        $'

lines       db 13,10,'  ____________________________________________________________________________  $'

downtab db 13,10,'$'
pressanykey db 13,10,'                    PLEASE PRESS ANY KEYBOARD KEY TO START$'

pleaseuse db   13,10,'                                   PLEASE USE                         $' 
pleaseuse1 db  13,10,'                   _____     ____________________     _____           $'
pleaseuse2 db  13,10,'                  |     |   |                    |   |     |          $'
pleaseuse3 db  13,10,'                  |  <  |   |        SPACE       |   |  >  |          $'
pleaseuse4 db  13,10,'                  |_____|   |____________________|   |_____|          $'

pleaseuse5 db   13,10,'                              TO MOVE THE CANON                      $'
                                                
;endgame                   
Pointscounter db 00h     ;counter of the points
screencounterX dw 000Ah  ;the last x of the point bar

youwin1 db 13,10,'             __   _____  _   _  __        _____  _   _ _                  $'        
youwin2 db 13,10,'             \ \ / / _ \| | | | \ \      / / _ \| \ | | |                 $'        
youwin3 db 13,10,'              \ V / | | | | | |  \ \ /\ / / | | |  \| | |                 $'        
youwin4 db 13,10,'               | || |_| | |_| |   \ V  V /| |_| | |\  |_|                 $'        
youwin5 db 13,10,'               |_| \___/ \___/     \_/\_/  \___/|_| \_(_)                 $'

goodjob db    13,10,'                       GOOD JOB YOU WON THE GAME                       $' 

presstoend db 13,10,'                         PRESS ANY KEY TO EXIT                         $'
;canonbody                            

XTopLeftBody dw 145d ;the left X of the canon body
YTopLeftBody dw 160d ;the top Y of the canon body

XRightButtomBody dw 175d ;the right X of the canon body 
YRightButtomBody dw 173d ;the buttom Y of the canon body

;canonbarrel

XTopLeftBarrel dw 153d ;the left X of the canon barrel (upper part)
YTopLeftBarrel dw 140d ;the top Y of the canon barrel

XRightButtomBarrel dw 167d ;the right X of the canon barrel 
YRightButtomBarrel dw 158d ;the buttom Y of the canon barrel

;bullet
Xbullet dw 0h ;the X of the current bullet
Ybullet dw 0h ;the Y of the current bullet

delaycheckbullet db 0h ;counter if you should use delay

;targets
       ;X<     Y^     X>     Y_  
tar1 dw 0025d ,0025d ,0035d ,0035d  ;Target number 1 arr
tar2 dw 0077d ,0041d ,0086d ,0050d  ;Target number 2 arr
tar3 dw 0215d ,0093d ,0230d ,00108d ;Target number 3 arr
tar4 dw 0238d ,0015d ,0255d ,0027d  ;Target number 4 arr
tar5 dw 0055d ,0090d ,0065d ,00100d ;Target number 5 arr
tar6 dw 0145d ,0060d ,0160d ,0075d  ;Target number 6 arr
tar7 dw 0295d ,0050d ,0315d ,0070d  ;Target number 7 arr



.CODE

proc delay
	pusha
	mov cx, 0001h   ;High Word
	mov dx, 0001h   ;Low Word
	mov ah, 86h   ;Wait
	int 15h
	popa
	ret
endp delay

checkandbreak proc ;no parmeter needs for the proc

tar1check:
    mov bx,offset tar1
    cmp cx,[bx]
    jb tar2check
    cmp cx,[bx+4]
    ja tar2check

	mov bx,offset tar1
	push 0000h                  ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 1
	inc Pointscounter
	call screenpoints
	
    jmp Deletebullet

tar2check:
    mov bx,offset tar2
    cmp cx,[bx]
    jb tar3check
    cmp cx,[bx+4]
    ja tar3check

    mov bx,offset tar2
	push 0000h                  ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 2
	inc Pointscounter
	call screenpoints                      
	                      
    jmp Deletebullet

tar3check:
    mov bx,offset tar3
    cmp cx,[bx]
    jb tar4check
    cmp cx,[bx+4]
    ja tar4check

    mov bx,offset tar3
	push 0000h                  ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 3
	inc Pointscounter 
	call screenpoints
	
    jmp Deletebullet

tar4check:
    mov bx,offset tar4
    cmp cx,[bx]
    jb tar5check
    cmp cx,[bx+4]
    ja tar5check

    mov bx,offset tar4
	push 0000h                  ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 4 
	inc Pointscounter 
	call screenpoints
	
    jmp Deletebullet

tar5check:
    mov bx,offset tar5
    cmp cx,[bx]
    jb tar6check
    cmp cx,[bx+4]
    ja tar6check

    mov bx,offset tar5
	push 0000h                  ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 5
	inc Pointscounter
	call screenpoints
	
    jmp Deletebullet

tar6check:
    mov bx,offset tar6
    cmp cx,[bx]
    jb tar7check
    cmp cx,[bx+4]
    ja tar7check

    mov bx,offset tar6
	push 0000h                  ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 6
    inc Pointscounter
    call screenpoints
    
    jmp Deletebullet

tar7check:
    mov bx,offset tar7
    cmp cx,[bx]
    jb deletebullet
    cmp cx,[bx+4]
    ja deletebullet

    mov bx,offset tar7
	push 0000h                  ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 7
	inc Pointscounter 
    call screenpoints    
    
ret 
checkandbreak endp  ;this proc is checking where the bullet of the canon striked and delete the target that its striked on 

drawline proc ;+8  ;+10=Y^ (upper Y of line) ;+12=Y_ (lower Y of line) ;+14=X (the X of the line) ;+16=Color
    push bx ;+6    
    push cx ;+4 ;x
    push dx ;+2 ;y
    push ax ;+0

    mov bp,sp
    mov cx, [bp+14]
    mov dx, [bp+10]
    mov ax, [bp+16]
    mov ah, 0Ch
drawpixelinline:
    int 10h
    inc dx
    cmp dx,[bp+12]
    jle drawpixelinline

    pop ax
    pop dx
    pop cx
    pop bx
ret 8
drawline endp ;this proc is draw a collum according to what you pushed
  
  
drawrectangle proc ;+8  ;+10=X< (the left X of the rectangle) +12= Y^ (the upper Y of the rectangle) +14= X> (the right X of the rectangle) +16= Y_ (the lower Y of the rectangle) +18=color
    push bx ;+6    
    push cx ;+4 ;x
    push dx ;+2 ;y
    push ax ;+0

    mov bp,sp 
    
    
    
    mov cx, [bp+10]
    mov dx, [bp+12]
    mov ax,[bp+18]
    mov ah,0ch
rectangdrawy:


ractangdrawlines:
    int 10h

    inc cx
    
    cmp cx, [bp+14]    
    jle ractangdrawlines
    
    inc dx
    mov cx, [bp+10]
    
    cmp dx, [bp+16]
    jle rectangdrawy
;end rectangle    
        
    
    pop ax
    pop dx
    pop cx
    pop bx    
ret 10   
drawrectangle endp ;this proc is draw a rectangle according to what you pushed


screenpoints proc ;no parmeter needs for the proc
pusha

mov cx,screencounterX
mov dx,196d
mov al,0Fh
mov ah,0Ch
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h

mov cx,screencounterX
mov dx,195d
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h 

mov cx,screencounterX
mov dx,194d
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h

mov cx,screencounterX
mov dx,193d
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h 

mov cx,screencounterX
mov dx,192d
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h
inc cx
int 10h


add screencounterX, 9    
popa
ret        
screenpoints endm ;this proc is drawing a point in the points bar 
    
    
endscreenproc proc ;no parmeter needs for the proc
    mov ah,00h
    mov al,03h
    int 10h
    
    mov ah,09h
    mov dx,offset youwin1 
    int 21h
    mov dx,offset youwin2
    int 21h
    mov dx,offset youwin3
    int 21h
    mov dx,offset youwin4
    int 21h
    mov dx,offset youwin5
    int 21h
    
    mov dx,offset downtab
    int 21h
    mov dx,offset downtab
    int 21h
    mov dx,offset goodjob
    int 21h
    mov dx,offset presstoend
    int 21h
    ret
endscreenproc endp ;this proc is showing the end screen of the game
      
                                                        
homescreen proc ;no parmeter needs for the proc
    
    mov ah, 9 
    
    lea dx, downtab
	int 21h
    
    lea dx, homescreen1
	int 21h 
	
	lea dx, homescreen2
	int 21h
	
	lea dx, homescreen3
	int 21h
	
	lea dx, homescreen4
	int 21h
	
	lea dx, homescreen5
	int 21h
	
	lea dx, downtab
	int 21h
	
	lea dx, downtab
	int 21h    
	
	lea dx, namepresentation
	int 21h   
	
	lea dx, downtab
	int 21h
	
	lea dx,lines
	int 21h
	
	lea dx, downtab
	int 21h         
	
	lea dx,pleaseuse
	int 21h
	
	lea dx, downtab
	int 21h
	
	lea dx,pleaseuse1
	int 21h           
	
	lea dx,pleaseuse2
	int 21h
	
	lea dx,pleaseuse3
	int 21h                  
	
	lea dx,pleaseuse4
	int 21h 
	
	lea dx, downtab
	int 21h
	
	lea dx,pleaseuse5
	int 21h
	
	lea dx, downtab
	int 21h
	
	lea dx, downtab
	int 21h
	
	lea dx, pressanykey
	int 21h 
	          
    
    ret    
homescreen endp ;this proc is showing the home screen of the game  

;------------------------------------------------------------------------------

start:
	mov ax, @data
    mov ds, ax              
	
	call homescreen
homescreenwait:
    mov ah,00
    int 16h
    cmp al,0
    je homescreenwait  	
	
	
	mov ah, 0                   ; set display mode function.
	mov al, 13h                 ; mode 13h = 320x200 pixels, 256 colors.
	int 10h                     ; set it! 
	
	xor ax,ax
	push 08h                    ;color grey
	mov al,198d
	push ax
	mov al,73d
	push ax
	mov al,190d
	push ax
	mov al,8d
	push ax 
	
	call drawrectangle
	
	
	push 0Fh                    ;color white   
	push YRightButtomBody       ;y down right  ;+18
	push XRightButtomBody       ;x down right  ;+16
	push YTopLeftBody           ;y up left  ;+14
	push XTopLeftBody           ;x up left  ;+12
	     
	call drawrectangle              ;canon base***
	
	
	push 0Fh                    ;color   
	push YRightButtomBarrel     ;y down right  ;+18 
	push XRightButtomBarrel     ;x down right  ;+16
	push YTopLeftBarrel         ;y up left  ;+14
	push XTopLeftBarrel         ;x up left  ;+12
	  
	call drawrectangle              ;canon barrel*** 
	 
	 
	mov bx,offset tar1
	push 0Ch                    ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 1
	
	
	mov bx,offset tar2
	push 0Ch                    ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 2
	
	
	mov bx,offset tar3
	push 0Ch                    ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 3
	
	
	mov bx,offset tar4
	push 0Ch                    ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 4
	
	
	mov bx,offset tar5
	push 0Ch                    ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 5
	
	
	mov bx,offset tar6
	push 0Ch                    ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 6
    
    
    mov bx,offset tar7
	push 0Ch                    ;color
	push [bx+6]                 ;y down right  ;+18
	push [bx+4]                 ;x down right  ;+16
	push [bx+2]                 ;y up left  ;+14
	push [bx]                   ;x up left  ;+12
	
	call drawrectangle              ;red target number 7 
	


;----------------------------------------------------------------------------------	


	RetroKeyWait:
    mov ah,00h
    int 16h
    
    cmp ah,00h
    je RetroKeyWait

    cmp ah,4Dh
    je MovRight
    
    cmp ah,4Bh
    je MovLeft
    
    cmp ah,39h
    je shoot
    
    jmp RetroKeyWait

Shoot:

    mov ax,XTopLeftBarrel
    mov Xbullet,ax
    add Xbullet,0007h
    mov ax,YTopLeftBarrel 
    mov Ybullet,ax
    sub Ybullet,0006h

    
    mov al,0Fh
    mov cx,Xbullet
    add Ybullet,0005h
    mov dx,Ybullet
    sub Ybullet,0005h
    mov ah,0Ch
    
drawbullet:

    int 10h
    dec dx
    cmp dx,Ybullet
    jae drawbullet
    
    call delay                 
    
reapetshooting: 

    mov al,0000h                     
    mov dx,Ybullet
    add dx,0005h
    mov cx,Xbullet                 
    mov ah,0Ch
    int 10h
    
    dec Ybullet
    mov dx,Ybullet
    mov cx,Xbullet
    mov ah,0Dh
    int 10h
    
    cmp al,0Ch
    je Deleterectang
    
    mov al,00Fh
    mov dx,Ybullet
    mov cx,Xbullet
    mov ah,0Ch
    int 10h   
    
    inc delaycheckbullet
    cmp delaycheckbullet,5h
    jne notcalldelay 
    
    call delay
    mov delaycheckbullet,0h
    
notcalldelay:    
    
    cmp Ybullet,1
    je Deletebullet
    
    jmp reapetshooting
    
Deleterectang:       ;cmp between X's
     
    call checkandbreak 
        
Deletebullet:
    mov al,0000h
    mov cx,Xbullet
    add Ybullet,0005h
    mov dx,Ybullet
    sub Ybullet,0005h
    mov ah,0Ch
drawbullet2:
    int 10h
    dec dx
    cmp dx,Ybullet
    jae drawbullet2    
    
    
    cmp Pointscounter,07h
    je endscreen                
    jmp RetroKeyWait


    
MovLeft: 
    push 0000h
    push XRightButtomBarrel
    push YRightButtomBarrel   
    push YTopLeftBarrel
    call drawline
    dec XRightButtomBarrel
    
    push 0000h
    push XRightButtomBody
    push YRightButtomBody
    push YTopLeftBody
    call drawline
    dec XRightButtomBody
    
    push 0000h
    push XRightButtomBarrel
    push YRightButtomBarrel   
    push YTopLeftBarrel
    call drawline
    dec XRightButtomBarrel
    
    push 0000h
    push XRightButtomBody
    push YRightButtomBody
    push YTopLeftBody
    call drawline
    dec XRightButtomBody
    
    
    
    push 000Fh
    dec XTopLeftBarrel
    push XTopLeftBarrel
    push YRightButtomBarrel
    push YTopLeftBarrel
    call drawline
    
    push 000Fh
    dec XTopLeftBody
    push XTopLeftBody
    push YRightButtomBody
    push YTopLeftBody   
    call drawline
    
    push 000Fh
    dec XTopLeftBarrel
    push XTopLeftBarrel
    push YRightButtomBarrel
    push YTopLeftBarrel
    call drawline
    
    push 000Fh
    dec XTopLeftBody
    push XTopLeftBody
    push YRightButtomBody
    push YTopLeftBody   
    call drawline
    
    jmp RetroKeyWait  
            
MovRight:
    push 0000h
    push XTopLeftBarrel
    push YRightButtomBarrel
    push YTopLeftBarrel
    call drawline
    inc XTopLeftBarrel

    push 0000h
    push XTopLeftBody
    push YRightButtomBody
    push YTopLeftBody   
    call drawline
    inc XTopLeftBody
    
    push 0000h
    push XTopLeftBarrel
    push YRightButtomBarrel
    push YTopLeftBarrel
    call drawline
    inc XTopLeftBarrel

    push 0000h
    push XTopLeftBody
    push YRightButtomBody
    push YTopLeftBody   
    call drawline
    inc XTopLeftBody
    
    
    
    push 000Fh
    inc XRightButtomBarrel
    push XRightButtomBarrel
    push YRightButtomBarrel
    push YTopLeftBarrel
    call drawline

    push 000Fh
    inc XRightButtomBody
    push XRightButtomBody
    push YRightButtomBody
    push YTopLeftBody
    call drawline
    
    push 000Fh
    inc XRightButtomBarrel
    push XRightButtomBarrel
    push YRightButtomBarrel
    push YTopLeftBarrel
    call drawline

    push 000Fh
    inc XRightButtomBody
    push XRightButtomBody
    push YRightButtomBody
    push YTopLeftBody
    call drawline
    
    jmp RetroKeyWait 
    
	
	
endscreen:
    
    call endscreenproc  
	
exit:
;wait for keypress 

  mov ah,00
  int 16h			
  cmp al,0
  je exit     
       
  mov AH,4CH
  int 21h
    
    
END start
