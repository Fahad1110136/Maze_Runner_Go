[org 0x0100]
jmp start
mazeiniloc: dw 340                          ; maze initial location
row: dw 20                                  ; total no of elements in a row
total: dw 400                               ; total no of elements  
checkrow: dw 0                              ; check for new row using (80-20)*2=120 where totalsize = 80, mazewidth = 20 and (x2) for byte
msg1: db '  Welcome to Maze! You can Navigate through Keyboard Arrows  $' 
msg2: db ' Get a Key and make it a Supra Man  $'     
timemsg: db 'Time: $'
scoremsg: db 'Score: $'
enemymsg: db 'Enemy: $'
pointsmsg: db 'Points: $'
supermodemsg: db 'Supraman key: $'
supermsg: db ' Walk through Walls $'
currentposition: dw 0                       ; starting position of smilling face (after start label)
supermanmode: db 0                          ; Superman mode flag
supermantimer: dw 0                         ; timer for superman mode
winmsg: db ' Congrats, You won the maze! $'
tickcount: dw 0                             ; no of ticks per second
seconds: dw 0                               ; time in seconds
points: dw 0                                ; player score
overmsg: db ' Game Over , Out of Time ! $'
flag: db 0
array1:                                     ; grid of 20 x 20 (20 rows and 20 columns)
    dw 1,'S',1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    dw 1,0x02, 1, 1, 1, 0, 0, 1, 0, 0 , 0, 0, 0, 0, 0, 0, 1, 1, 0, 1
    dw 1, 0, 0, 0, 0, 0, 1, 1, 0, 1 , 1, 1, 0, 1, 1, 0, 1, 1, 0, 1
    dw 1, 1, 1, 1, 1, 0x03, 1, 1, 0, 1 , 1, 0, 0, 0, 1, 0, 0, 0, 0, 1
    dw 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 , 0, 1, 1, 0, 1,0x15, 1, 1, 1, 1
    dw 1, 1, 1, 0, 1, 0, 1, 1, 1, 1 , 0, 0, 1, 0, 0, 0, 1, 0, 1, 1
    dw 1, 0, 1, 0, 1, 1, 0, 0, 1, 0 , 0, 0, 1, 1, 1, 1, 1, 0, 1, 1
    dw 1, 0, 0,0x15, 0, 0, 1, 0, 1, 0 , 1, 0, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 0, 1, 1, 0, 0, 1, 1, 1 , 1, 0, 1, 1, 1, 0, 0, 1, 1, 1
    dw 1, 0, 1, 1, 1, 0, 0, 0, 0, 0 , 0, 0, 1,0x03, 0, 0, 1, 1, 1, 1
	dw 1, 0, 1, 0, 0, 0, 1, 1, 1, 0 , 0, 0, 1, 0, 1, 0, 0, 1, 0, 1
    dw 1, 0, 1,0x0C, 1, 0, 0, 1, 0, 0 , 1, 0, 0, 0, 0, 0, 1, 1, 0, 1
    dw 1, 0, 1, 0, 0, 0, 1, 0,0x03, 1 , 1, 1, 1, 1, 1, 0, 1, 1, 0, 1
    dw 1, 1, 1, 1, 1, 0, 1, 1, 0, 0 , 1, 0, 0, 0, 1, 0, 0, 0, 0, 1
    dw 1, 0, 0,0x15, 1, 0, 0, 0, 0, 1 , 1, 1, 1, 0, 1, 0, 1, 1, 1, 1
    dw 1, 1, 1, 0, 1, 0, 1, 1, 1, 1 , 1, 0, 1, 0, 0, 0, 0, 0, 1, 1
    dw 1, 0, 1, 0, 0, 0, 0, 0, 0, 0 , 1, 0, 1, 1, 1, 1, 1, 0, 1, 1
    dw 1, 0, 1, 1, 1, 1, 1, 0, 1, 1 , 1, 0, 0, 0,0x15, 0, 0, 0, 0, 1
    dw 1, 0, 0, 1, 0x03, 0, 0, 0, 0, 0 , 1, 'E', 1, 1, 0, 1, 1, 1, 0, 1
    dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1
array2:              
    dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    dw 1, 0, 1, 1, 1, 0, 0, 1, 0, 0 , 0, 0, 1, 0, 0, 0, 1, 1, 0, 1
    dw 1, 0, 0, 0,0x15, 0, 1, 1, 0, 1 , 1, 1, 1, 1, 1, 0, 0, 0, 0, 1
    dw 1, 0, 1, 1, 1, 0, 1, 1, 0,0x03 , 0, 0, 0, 0, 1, 1,0x15, 1, 0, 1
    dw 1, 0, 0, 0, 1, 0, 0, 0, 0, 1 , 0, 1, 1, 0, 1, 0, 0, 1, 1, 1
    dw 1, 0, 1, 0, 1, 0, 1, 1, 1, 1 , 0, 0, 1, 0, 0, 0, 1, 0, 1, 1
    dw 1, 0, 1,0x03, 0, 1, 0, 0, 1, 0 , 0, 0, 1, 1, 1, 1, 1, 0, 1, 1
    dw 1, 0, 1, 1, 1, 1, 1, 0, 1, 0 , 1, 0, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 0, 0, 1, 0, 0, 0, 0,0x15 , 1, 0, 1, 1, 1, 0, 0, 1, 0, 1
    dw 1, 0, 1, 1, 1, 0, 0, 1, 0, 1 , 0, 0, 1, 0, 0, 0, 1, 1, 0, 1
	dw'S',0x02, 1, 0, 1, 1, 0, 1, 1, 1 , 0, 0, 1, 0, 1, 0, 0, 1, 0, 1
    dw 1, 0, 1, 0, 1, 0, 0, 1, 0, 1 , 1, 0, 0, 0, 0,0x03, 1, 1, 0, 1
    dw 1, 0, 1, 0, 0, 0, 1, 1, 0, 1 , 1, 1, 1, 0, 1, 0, 1, 1, 0, 1
    dw 1, 0, 1, 1, 1, 0, 1,0x0C, 0, 0 , 1, 0, 0, 0, 1, 0, 0, 0, 0, 1
    dw 1, 0, 0, 0, 1, 0, 0, 0, 0, 1 , 1, 1, 1, 0, 1, 1, 1, 1, 1, 1
    dw 1, 1, 1, 0, 1, 0, 1, 1, 1, 1 , 1,0x15, 1, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0,0x03, 0, 0, 0, 0, 0, 0, 0 , 0, 0, 1, 1, 0, 1, 1, 0, 1, 1
    dw 1, 0, 1, 1, 1, 1, 1, 0, 1, 1 , 1, 0, 1, 1, 1, 1, 1, 0, 0, 1
    dw 1, 0, 1, 1, 0, 0, 0, 0, 0, 1 , 1, 0, 1,'E',0, 0, 0, 0, 1, 1
    dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
array3:              
    dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1,'S',1
    dw 1, 0, 1, 1, 1, 0, 0, 1, 0, 0 , 0, 0, 0, 0, 0, 0, 1, 1, 0x02, 1
    dw 1, 0, 0,0x03, 0, 0, 1, 1, 0, 1 , 1, 1, 0, 1, 1, 0, 1, 1, 0, 1
    dw 1, 1, 1, 1, 1, 0, 1, 1, 0, 1 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 , 0, 1, 1, 0, 1, 0, 1, 1, 0, 1
    dw 1, 1, 1, 0, 1, 0, 1, 1, 1, 1 , 0, 0, 1,0x0C, 0, 0, 1, 0, 1, 1
    dw 1, 0, 1,0x15, 1, 1, 0, 0, 1, 0 , 0, 0, 1, 1, 1, 1, 1, 0, 1, 1
    dw 1, 0, 0, 0, 0, 0, 1, 0, 1, 0 , 1, 0, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 0, 1, 1, 0, 0, 1, 1, 1 , 1, 0, 1, 1, 1,0x03, 0, 1, 1, 1
    dw 1, 0, 1, 1, 1, 0, 0, 0, 0, 0 , 0, 0, 1, 0, 0, 0, 1, 1, 1, 1
    dw 1, 0, 1, 0, 0, 0, 1, 1, 1, 0 , 0, 0, 1, 0, 1, 0, 0, 1, 0, 1
    dw 1, 0, 1, 0, 1, 0, 0, 1, 0, 0 , 1,0x15, 0, 0, 0, 0, 1, 1, 0, 1
    dw 1, 0, 1,0x15, 0, 0, 1, 0, 0, 1 , 1, 1, 1, 1, 1, 0, 1, 1, 0, 1
    dw 1, 1, 1, 1, 1, 0, 1, 1, 0, 0 , 1, 0, 0, 0, 1, 0, 0, 0, 0, 1
    dw 1, 0, 0, 0, 1, 0, 0, 0, 0, 1 , 1, 1, 1, 0, 1, 0, 1, 1, 1, 1
    dw 1, 0, 1, 0, 1, 0, 1, 1, 1, 1 , 1, 0, 1,0x03, 0, 0, 0, 0, 1, 1
    dw 1, 0, 1,0x03, 0, 0, 0, 0, 0, 0 , 1, 0, 1, 1, 1, 1, 1, 0, 1, 1
    dw 1, 0, 1, 1, 1, 1, 1, 0, 1, 1 , 1, 0, 0, 0, 0,0x15, 0, 0, 0, 1
    dw 1,'E', 1, 1, 0, 0, 0, 0, 0, 0 , 1, 0, 1, 1, 0, 1, 1, 1, 0, 1
    dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
array4:              
    dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    dw 1, 0, 0, 0, 0, 0, 0, 1, 0, 0 , 0, 1, 1, 1, 1, 1, 1, 0, 1, 1
    dw 1, 0, 1, 1, 0, 1, 1, 1, 1, 0 , 1, 1, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 0, 0, 0,0x15, 0, 0, 0, 0 , 1, 0, 1, 1, 1, 1, 1, 1, 0, 1
    dw 1,'E',0, 1, 1, 1, 1, 1, 0, 1 , 0, 0, 0, 1,0x03, 0, 0, 0, 0, 1
    dw 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 , 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
    dw 1, 0, 1, 1, 1, 1, 0, 1, 1, 0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 0, 0, 0, 0,0x0C, 0, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
    dw 1, 1, 1, 0, 1, 1, 1, 0, 0, 0 , 0, 0, 0, 1,0x15, 0, 0, 1, 1, 1
    dw 1, 0, 1, 0, 0, 0, 1, 0, 1, 0 , 0, 1, 1, 1, 1, 1, 0, 1, 0, 1
    dw 1, 0,0x03, 0, 1, 0, 1, 0, 1, 0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 1, 0, 0, 0, 1, 0, 0, 0 , 0, 1, 1, 1, 1, 0, 0, 1, 0, 1
    dw 1, 1, 1, 0, 0, 1, 1, 1, 1, 1 , 1,0x03, 1, 1, 1, 0, 0, 1, 1, 1
    dw 1, 0, 1, 1, 1, 0, 0, 0, 0, 0 , 1, 0, 1, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 1, 0, 0, 1, 1, 1, 1, 1 , 0, 0, 0, 0, 0, 1, 1, 1, 0, 1
    dw 1, 0, 0,0x15, 0, 0, 0, 0, 0, 1 , 0, 1, 0, 1, 0, 0, 0,0x02,'S',1
    dw 1, 0, 1, 1, 1, 1, 0, 1, 1, 1 , 0, 1, 0, 1, 1, 1, 1, 1, 1, 1
    dw 1, 0, 1, 0, 0, 0, 0, 0, 0, 0 , 0, 1, 0, 1, 1, 0, 0, 0, 1, 1
    dw 1, 0, 1, 1,0x03, 1, 1, 1, 0, 1 , 1, 1,0x15, 0, 0, 0, 1, 0, 1, 1
    dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1 ,1, 1, 1, 1, 1, 1, 1, 1
array5:              
    dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    dw 1, 0, 1, 1, 1, 0, 0, 1, 0, 0 , 0,0x03, 1, 0, 0, 0, 0, 1, 0, 1
    dw 1, 0, 0,0x15, 0, 0, 1, 1, 0, 1 , 1, 0, 1, 1, 1, 0, 1, 1, 0, 1
    dw 1, 0, 1, 1, 1, 0, 1, 1, 0, 0 , 0, 0, 0, 0, 1, 0, 0, 0, 0, 1
    dw 1, 0, 1, 0, 0, 0,0x0C, 0, 0, 1 , 1, 0, 1, 0, 1, 0, 1, 0, 1, 1
    dw 1, 1, 1, 0, 1, 0, 1, 1, 1, 1 , 1, 0, 1, 0, 0,0x15, 1, 0, 1, 1
    dw 1, 0, 1, 0, 1, 1, 0, 0, 0,'E', 0, 0, 1, 1, 1, 1, 1, 0, 1, 1
    dw 1,0x03, 0, 0, 0, 0, 1, 1, 1, 1 , 1, 1, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 0, 1, 1, 0, 0, 1, 0, 1 , 1, 1, 1, 1, 1, 1, 0, 1, 1, 1
    dw 1, 1, 1, 1, 1, 1, 0, 0, 0, 0 , 0, 0, 0, 0,0x03, 0, 0, 0, 1, 1
    dw 1, 0, 1, 0, 0, 1, 1, 1, 1, 1 , 1, 1, 1, 0, 1, 1, 1, 0, 0, 1
    dw 1, 0, 0, 0, 1, 0, 0, 0,'S',0 , 0, 0, 1, 0, 0, 0, 1, 1, 0, 1
    dw 1, 0x015, 1, 0, 0, 1, 0, 1,0x02, 1 , 1, 1, 1, 1, 0, 1, 1, 1, 0, 1
    dw 1, 0, 1, 1, 1, 1, 0, 1, 0, 1 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 , 1, 1, 1, 0, 1, 0, 1, 1, 1, 1
    dw 1, 0, 1, 0, 1, 1, 1, 0, 1, 1 , 1, 0, 1, 0,0x15, 0, 0, 0, 1, 1
    dw 1, 0, 1, 0, 0, 1, 0, 0, 0, 0 , 1, 0, 1, 1, 1, 1, 1, 0, 1, 1
    dw 1, 0, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 0, 0, 0, 0, 0, 0, 0, 0, 1
    dw 1, 0, 0, 0, 0,0x03, 0, 0, 0, 0 , 0, 0, 1, 1, 0, 1, 1, 1, 0, 1
    dw 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
clearscreen:
push bp
mov bp,sp
mov ax,0xB800         
mov es,ax
mov di,0              
mov cx,2000          
c1:
cmp cx, 0
je c2
mov word[es:di],0x5820
add di,2
dec cx
jmp c1
c2:
mov sp,bp
pop bp
ret
drawborders:
mov ax,0xb800
mov es,ax
mov di,0
mov ah,0xEF
mov al,0x0F
h1:
mov word[es:di],ax
call delay
add di,2
cmp di,160
jnz h1 
mov di,160
mov ah,0x06
h2:
mov word[es:di],ax
call delay
add di,2
cmp di,320
jnz h2
mov di,4000
sub di,160
mov dx,di
mov di,4000
sub di,320
mov ah,0xEF
h3:
mov word[es:di],ax
call delay
add di,2
cmp di,dx
jnz h3
mov di,4000
sub di,320
mov dx,di
mov di,4000
sub di,480
mov ah,0x06
h4:
mov word[es:di],ax
call delay
add di,2
cmp di,dx
jnz h4
mov di,320
mov ah,0xEF
mov al,0x0F
mov cx,20
h5:
mov word[es:di],ax
call delay
add di,160
loop h5
mov di,322
mov cx,20
mov ah,0x06
h6:
mov word[es:di],ax
call delay
add di,160
loop h6
mov ah,0xEF
mov di,478
mov cx,20
h7:
mov word[es:di],ax
call delay
add di,160
loop h7
mov ah,0x06
mov di,476
mov cx,20
h8: 
mov word[es:di],ax
call delay
add di,160
loop h8
ret
printmsg:
push bp
mov bp,sp
mov ax,0xB800
mov es,ax
call delay
mov si,timemsg
mov di,880
mov ah,0x0E
m1:
mov al,[si]
cmp al,'$'
jz m2
mov [es:di],ax
call delay
add si,1
add di,2
jmp m1
m2:
call delay
mov si,scoremsg
mov di,1200
mov ah,0x0E
a1:
mov al,[si]
cmp al,'$'
jz a2
mov [es:di],ax
call delay
add si,1
add di,2
jmp a1
a2:
call delay
mov si,pointsmsg
mov di,1520
mov ah,0x0E
g1:
mov al,[si]
cmp al,'$'
jz g2
mov [es:di],ax
call delay
add si,1
add di,2
jmp g1
g2:
call delay
mov di,1536
mov ah,0x0B
mov al,0x03
mov [es:di],ax
call delay
mov si,enemymsg
mov di,1840
mov ah,0x0E
j1:
mov al,[si]
cmp al,'$'
jz j2
mov [es:di],ax
call delay
add si,1
add di,2
jmp j1
j2:
call delay
mov di,1854
mov ah,0x0B
mov al,0x15
mov [es:di],ax
call delay
mov si,supermodemsg
mov di,2160
mov ah,0x0E
y1:
mov al,[si]
cmp al,'$'
jz y2
mov [es:di],ax
call delay
add si,1
add di,2
jmp y1
y2:
call delay
mov di,2188
mov ax,0x0B0C
mov [es:di],ax
mov si,supermsg
mov di,2192
mov ah,0x0B
r1:
mov al,[si]
cmp al,'$'
jz r2
mov [es:di],ax
call delay
add si,1
add di,2
jmp r1
r2:
call delay
mov di,3544
mov si,msg1
d1:
mov al,[si]
cmp al,'$'
jz d2
mov ah,0x5A
mov [es:di],ax
call delay
inc si
add di,2
jmp d1
d2:
call delay
mov si,msg2
mov di,3724
l1:
mov al,[si]
cmp al,'$'
jz l2
mov ah,0x02
mov [es:di],ax
call delay
inc si
add di,2
jmp l1
l2:
mov sp,bp
pop bp
ret
delay:
push cx
mov cx,1                                    ; change values to increase delay time
delayloop1:
push cx
mov cx,0xAAAA                               ; change values to increase delay time
delayloop2:
loop delayloop2
pop cx
loop delayloop1
pop cx
ret
Maze1:
push bp
mov bp,sp
mov ax,0xB800        
mov es,ax
mov si,array1                               ; load address of array (grid) in si
mov di,[mazeiniloc]                         ; di => lcation of first place **************imp
mov cx,[total]                              ; total elements in the maze (20x20=400) & no of times code draw maze charecters***imp
mov dx,0 
drawMaze1:                                  ; counter for managing no of elements in current row
mov bx,[si]                                 ; load current maze element 
cmp bx,0x15
je printenemy1
cmp bx,0x03
je printfriend1
cmp bx,0x02
je movingcharecter1
cmp bx,0x0C
je supermode1
cmp bx,'S'
je labelS1
cmp bx,'E'
je labelE1
cmp bx,0
je openarea1         
mov ax,0x4423                               ; # charecter showing walls of maze  
jmp printcharecter1
openarea1:
mov ax,0x1120                               ; space character showing path of maze
jmp printcharecter1
labelS1:
mov ax,0xEF53
jmp printcharecter1
labelE1:
mov ax,0xEF45
jmp printcharecter1
movingcharecter1:
mov [currentposition],di                    ;  position from where charecter starts moving
mov ax,0x0F02
jmp printcharecter1
printenemy1:
mov ax,0x1F15
jmp printcharecter1
printfriend1:
mov ax,0x1D03
jmp printcharecter1
supermode1:
mov ax,0x1E0C
jmp printcharecter1
printcharecter1:
mov word[es:di],ax
call delay 
add di,2                                    ; move to next position in video memory
add si,2                                    ; move to next element in array
inc dx                                      ; increment row counter  
cmp dx,[row]                                ; checking if end of row reached (maximum elements in a row reached)**imp
jne continuerow1
nextrow1:   
mov dx,80                                   ; reset row counter for new line 
sub dx,[row]
shl dx,1
mov [checkrow],dx
mov dx,0
add di,[checkrow]                           ; move to next row using (80-20)2=120 where totalsize = 80, mazewidth = 20 and (x2) for byte*imp
continuerow1:
sub cx,1
cmp cx,0
jnz drawMaze1                               ; repeat for all elements again 
mov sp,bp
pop bp
ret
Maze2:
push bp
mov bp,sp
mov ax,0xB800        
mov es,ax
mov si,array2                               ; load address of array (grid) in si
mov di,[mazeiniloc]                         ; di => lcation of first place
mov cx,[total]                              ; total elements in the maze (20x20=400) & no of times code draw maze charecters***imp
mov dx,0                                    ; counter for managing no of elements in current row
drawMaze2:
mov bx,[si]                                 ; load current maze element 
cmp bx,0x15
je printenemy2
cmp bx,0x02
je movingcharecter2
cmp bx,0x03
je printfriend2
cmp bx,0x0C
je supermode2
cmp bx,'S'
je labelS2
cmp bx,'E'
je labelE2
cmp bx,0
je openarea2          
mov ax,0x4423                               ; # charecter showing walls of maze  
jmp printcharecter2
openarea2:
mov ax,0x1120                               ; space character showing path of maze
jmp printcharecter2
labelS2:
mov ax,0xEF53
jmp printcharecter2
labelE2:
mov ax,0xEF45
jmp printcharecter2
movingcharecter2:
mov [currentposition],di
mov ax,0x0F02
jmp printcharecter2
printenemy2:
mov ax,0x1F15
jmp printcharecter2
printfriend2:
mov ax,0x1D03
jmp printcharecter2
supermode2:
mov ax,0x1E0C
jmp printcharecter2
printcharecter2:
mov word[es:di],ax 
call delay  
add di,2                                    ; move to next position in video memory
add si,2                                    ; move to next element in array
inc dx                                      ; increment row counter  
cmp dx,[row]                                ; checking if end of row reached (maximum elements in a row reached)**imp
jne continuerow2
nextrow2:   
mov dx,80                                   ; Reset row counter for new line 
sub dx,[row]
shl dx,1
mov [checkrow],dx
mov dx,0
add di,[checkrow]                           ; move to next row using (80-20)*2=120 where totalsize = 80, mazewidth = 20 and (x2) for byte ********imp
continuerow2:
sub cx,1
cmp cx,0
jnz drawMaze2                               ; repeat for all elements again 
mov sp,bp
pop bp
ret   
Maze3:
push bp
mov bp,sp
mov ax,0xB800        
mov es,ax
mov si,array3                               ; load address of array (grid) in si
mov di,[mazeiniloc]                         ; di => lcation of first place **************imp
mov cx,[total]                              ; total elements in the maze (20x20=400) & no of times code draw maze charecters***imp
mov dx,0 
drawMaze3:                                  ; counter for managing no of elements in current row
mov bx,[si]                                 ; load current maze element 
cmp bx,0x15
je printenemy3
cmp bx,0x02
je movingcharecter3
cmp bx,0x03
je printfriend3
cmp bx,0x0C
je supermode3
cmp bx,'S'
je labelS3
cmp bx,'E'
je labelE3
cmp bx,0
je openarea3         
mov ax,0x4423                               ; # charecter showing walls of maze  
jmp printcharecter3
openarea3:
mov ax,0x1120                               ; space character showing path of maze
jmp printcharecter3
labelS3:
mov ax,0xEF53
jmp printcharecter3
labelE3:
mov ax,0xEF45
jmp printcharecter3
movingcharecter3:
mov [currentposition],di
mov ax,0x0F02
jmp printcharecter3
printenemy3:
mov ax,0x1F15
jmp printcharecter3
printfriend3:
mov ax,0x1D03
jmp printcharecter3
supermode3:
mov ax,0x1E0C
jmp printcharecter3
printcharecter3:
mov word[es:di],ax 
call delay  
add di,2                                    ; move to next position in video memory
add si,2                                    ; move to next element in array
inc dx                                      ; increment row counter  
cmp dx,[row]                                ; checking if end of row reached (maximum elements in a row reached)**imp
jne continuerow3
nextrow3:   
mov dx,80                                   ; reset row counter for new line 
sub dx,[row]
shl dx,1
mov [checkrow],dx
mov dx,0
add di,[checkrow]                           ; move to next row using (80-20)2=120 where totalsize = 80, mazewidth = 20 and (x2) for byte*imp
continuerow3:
sub cx,1
cmp cx,0
jnz drawMaze3                               ; repeat for all elements again 
mov sp,bp
pop bp
ret
Maze4:
push bp
mov bp,sp
mov ax,0xB800        
mov es,ax
mov si,array4                               ; load address of array (grid) in si
mov di,[mazeiniloc]                         ; di => lcation of first place **************imp
mov cx,[total]                              ; total elements in the maze (20x20=400) & no of times code draw maze charecters***imp
mov dx,0 
drawMaze4:                                  ; counter for managing no of elements in current row
mov bx,[si]                                 ; load current maze element 
cmp bx,0x15
je printenemy4
cmp bx,0x02
je movingcharecter4
cmp bx,0x03
je printfriend4
cmp bx,'S'
je labelS4
cmp bx,'E'
je labelE4
cmp bx,0x0C
je supermode4
cmp bx,0
je openarea4         
mov ax,0x4423                               ; # charecter showing walls of maze  
jmp printcharecter4
openarea4:
mov ax,0x1120                               ; space character showing path of maze
jmp printcharecter4
labelS4:
mov ax,0xEF53
jmp printcharecter4
labelE4:
mov ax,0xEF45
jmp printcharecter4
movingcharecter4:
mov [currentposition],di
mov ax,0x0F02
jmp printcharecter4
printenemy4:
mov ax,0x1F15
jmp printcharecter4
printfriend4:
mov ax,0x1D03
jmp printcharecter4
supermode4:
mov ax,0x1E0C
jmp printcharecter4
printcharecter4:
mov word[es:di],ax 
call delay  
add di,2                                    ; move to next position in video memory
add si,2                                    ; move to next element in array
inc dx                                      ; increment row counter  
cmp dx,[row]                                ; checking if end of row reached (maximum elements in a row reached)**imp
jne continuerow4
nextrow4:   
mov dx,80                                   ; reset row counter for new line 
sub dx,[row]
shl dx,1
mov [checkrow],dx
mov dx,0
add di,[checkrow]                           ; move to next row using (80-20)2=120 where totalsize = 80, mazewidth = 20 and (x2) for byte*imp
continuerow4:
sub cx,1
cmp cx,0
jnz drawMaze4                               ; repeat for all elements again 
mov sp,bp
pop bp
ret
Maze5:
push bp
mov bp,sp
mov ax,0xB800        
mov es,ax
mov si,array5                               ; load address of array (grid) in si
mov di,[mazeiniloc]                         ; di => lcation of first place **************imp
mov cx,[total]                              ; total elements in the maze (20x20=400) & no of times code draw maze charecters***imp
mov dx,0 
drawMaze5:                                  ; counter for managing no of elements in current row
mov bx,[si]                                 ; load current maze element 
cmp bx,0x15
je printenemy5
cmp bx,0x02
je movingcharecter5
cmp bx,0x03
je printfriend5
cmp bx,0x0C
je supermode5
cmp bx,'S'
je labelS5
cmp bx,'E'
je labelE5
cmp bx,0
je openarea5         
mov ax,0x4423                               ; # charecter showing walls of maze  
jmp printcharecter5
openarea5:
mov ax,0x1120                               ; space character showing path of maze
jmp printcharecter5
labelS5:
mov ax,0xEF53
jmp printcharecter5
labelE5:
mov ax,0xEF45
jmp printcharecter5
movingcharecter5:
mov [currentposition],di
mov ax,0x0F02
jmp printcharecter5
printenemy5:
mov ax,0x1F15
jmp printcharecter5
printfriend5:
mov ax,0x1D03
jmp printcharecter5
supermode5:
mov ax,0x1E0C
jmp printcharecter5
printcharecter5:
mov word[es:di],ax   
call delay
add di,2                                    ; move to next position in video memory
add si,2                                    ; move to next element in array
inc dx                                      ; increment row counter  
cmp dx,[row]                                ; checking if end of row reached (maximum elements in a row reached)**imp
jne continuerow5
nextrow5:   
mov dx,80                                   ; reset row counter for new line 
sub dx,[row]
shl dx,1
mov [checkrow],dx
mov dx,0
add di,[checkrow]                           ; move to next row using (80-20)2=120 where totalsize = 80, mazewidth = 20 and (x2) for byte*imp
continuerow5:
sub cx,1
cmp cx,0
jnz drawMaze5                               ; repeat for all elements again 
mov sp,bp
pop bp
ret
kbisr:                                      ; key board interrupt service routine
push ax
push es
push di
push si  
in al,0x60                                  ; reads a char from the key board
cmp al,0x48                                 ; scan code of up arrow key
je moveup
cmp al,0x50                                 ; scan code of down arrow key
je movedown
cmp al,0x4B                                 ; scan code of left arrow key
je moveleft
cmp al,0x4D                                 ; scan code of right arrow key
je moveright
jmp exitkbisr                               ; no such arrow press exit interrupt routine
moveup:
mov ax,[currentposition]
sub ax,160                                  ; move up one row
call checkcollision
jmp exitkbisr
movedown:
mov ax,[currentposition]
add ax,160                                  ; move down one row
call checkcollision
jmp exitkbisr    
moveleft:
mov ax,[currentposition]
sub ax,2                                    ; move left one column
call checkcollision
jmp exitkbisr    
moveright:
mov ax,[currentposition]
add ax,2                                    ; move right one column
call checkcollision    
exitkbisr:
mov al,0x20
out 0x20,al                                 ; end of interrupt
pop si
pop di
pop es
pop ax
iret
checkcollision:                             ; collision detection
push bp
mov bp,sp
push bx
push dx    
mov bx,ax                                   ; store target position
cmp bx, 0                                   ; top boundary (after first row)
jl boundaryfail                             ; basic boundary check for maze (normal conditions)                   
cmp bx, 3360                                ; bottom boundary (before last row)
jg boundaryfail
mov ax,0xB800
mov es,ax
mov dx,[es:bx]                              ; get character at target position
cmp dl,'E'                                  ; check end label first
je gamewon
cmp dh,0x44                                 ; check wall character attribute
je checkifsuperman
cmp dl,0x0C                                 ; check to activate superman power up
je activatesuperman
cmp dl,0x03                                 ; check to add points (heart)
je collectpoints    
cmp dl,0x15                                 ; check to hit enemy: remove points
je hitenemy
jmp updateposition
boundaryfail:
jmp endcheck                                ; no above condition so stop checking the conditions
checkifsuperman:
cmp byte[supermanmode],1
je updateposition                           ; if superman mode active, allow through walls
jmp endcheck                                ; if not in superman mode, don't move through walls
updateposition:
mov di,[currentposition]                    ; updating new places
mov word[es:di],0x1120                      ; place space character    
mov [currentposition],bx
mov di,bx                                   ; swap condition
mov word[es:di],0x0F02                      ; place smiling face character
endcheck:
pop dx
pop bx
mov sp,bp
pop bp
ret
activatesuperman:
mov byte[supermanmode],1                    ; super man mode activate
mov word[supermantimer],10                  ; super man mode activated time  
jmp updateposition
collectpoints:
push ax
mov ax,[points]
add ax,200                                  ; add 200 points
mov [points],ax
call printscore                             ; updated score display
pop ax
jmp updateposition
hitenemy:
push ax
mov ax,[points]
cmp ax,0
je s
sub ax,100                                  ; subtract 5 points
s:
call printscore                             ; updated score display
pop ax
jmp updateposition
gamewon:
push ax
push dx
mov ax,0xB800
mov es,ax
mov di,2480
mov si,winmsg
mov ah,0x2F
mov word[flag],1                            ; set win flag if reach end 
printwin:
mov al,[si]
cmp al,'$'
je skipsuperman
je endwin
mov [es:di],ax
inc si
add di,2
jmp printwin
endwin:
pop dx
pop ax
jmp updateposition                          ; allow final move to 'E' as you finish maze
time:                                       ; time interrupt service routine
push ax
push bx                          
push dx
inc word[tickcount]                         ; always increment tick count
cmp word[tickcount],20                      ; check if a second has passed , 1 second = 20 tickcount
jnz skipreset
cmp word[flag],1                            ; check if game is won , flag = 0 = won
je skipreset                                ; if won, don't increment seconds
cmp byte[supermanmode],1                    ; check superman mode , if supermanmode = 1 it means on
jne skipsuperman
dec word[supermantimer]                     ; decrease superman timer
cmp word[supermantimer],0
jne skipsuperman
mov byte[supermanmode],0                    ; disable superman mode if timer is 0
skipsuperman:
mov word[tickcount],0                       ; reset tick count
inc word[seconds]                           ; increment seconds
cmp word[seconds],61                        ; check if time is up
je f                                        ; jump to game over if time is up
skipreset:
call printtime
timeend:
mov al,0x20
out 0x20,al
pop dx
pop bx
pop ax
iret
printtime:                                 ; print current time                             
mov ax,0xB800 
mov es,ax 
mov ax,[seconds] 
mov bx,10 
mov cx,0 
p1:
mov dx,0  
div bx 
add dl,0x30
push dx
inc cx 
cmp ax,0 
jnz p1
mov di,892
p2:
pop dx
mov dh,0x0B  
mov [es:di],dx 
add di,2 
loop p2  
ret
printscore:                      
push bp
mov bp,sp
pusha
mov [points],ax
mov ax,0xB800 
mov es,ax 
mov ax,[points] 
mov bx,10 
mov cx,0 
q1:
mov dx,0  
div bx 
add dl,0x30
push dx
inc cx 
cmp ax,0 
jnz q1
mov di,1214
q2:
pop dx
mov dh,0x0B  
mov [es:di],dx 
add di,2
loop q2              
popa
mov sp,bp
pop bp
ret
start:          
call clearscreen
call drawborders
call Maze5
call printmsg
xor ax,ax
mov es,ax
cli
mov word[es:9*4],kbisr                      ; set up keyboard interrupt
mov [es:9*4+2],cs    
mov word[es:8*4],time                       ; set up timer interrupt
mov [es:8*4+2],cs
sti    
mov word[points],0                          ; initialize points to 0
mov word[flag],0                            ; initialize win flag
call printscore   
endgame:
cmp word[seconds],61
je f
jne y
y:
cmp word[flag],1
je end
jne f1
f:
mov si,overmsg                              ; print game over msg
mov di,2480
t:
mov ah,0x05
mov al,[si]
cmp al,'$'
je end 
mov [es:di],ax
call delay
add si,1
add di,2
jmp t
f1:
loop endgame
end:        
mov ax,0x4C00         
int 0x21