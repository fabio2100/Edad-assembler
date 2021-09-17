.model small							;1
.stack 100h								;
.data									;
mesadig1 db ?								;
mesadig2 db ?								
mesndig1 db ?
mesndig2 db ?
diaadig1 db ?
diaadig2 db ?
diandig1 db ?
diandig2 db ?
aactdig1 db ?
aactdig2 db ?
aactdig3 db ?
aactdig4 db ?
anacdig1 db ?
anacdig2 db ?
anacdig3 db ?
anacdig4 db ?
edaddig1 db 0
edaddig2 db 0
edaddig3 db 0
edaddig4 db 0

mesn db 10,13,'Ingrese mes de nacimiento(mm): $'
mesa db 10,13,'Ingrese mes actual(mm): $'
mescoinc1 db 10,13,'mes coincide $'				;10
yacumplio db 10,13,'Este año ya cumplió años. $'
todnoc	db 10,13,'Este año todavía no cumple años. $'
fc db 10,13,'Hoy es su cumpleaños, Feliz cumpleaños $'
diaa db 10,13,'Ingrese dia actual(dd): $'
dian db 10,13,'Ingrese dia de nacimiento(dd): $'
aact db 10,13,'Ingrese año actual(aaaa): $'
anac db 10,13,'Ingrese año de nacimiento(aaaa): $'
mosedad db 10,13,'Su edad es: $'
mosedadfc db 10,13,'Hoy está cumpliendo $'
mosedadfcd db ' años $'
imp db 10,13,'El año actual debe ser mayor o igual que el año de nacimiento $'

.code
start:


tomadatos:
	mov ax,@data
	mov ds,ax
	mov dx,offset diaa
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	sub al,30h
	mov diaadig1,al
	int 21h
	sub al,30h
	mov diaadig2,al
	mov dx,offset mesa
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	sub al,30h							;20
	mov mesadig1,al
	int 21h
	sub al,30h
	mov mesadig2,al
	mov dx,offset aact
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	sub al,30h
	mov aactdig1,al
	int 21h
	sub al,30h
	mov aactdig2,al
	int 21h
	sub al,30h
	mov aactdig3,al
	int 21h
	sub al,30h
	mov aactdig4,al
	mov dx,offset dian
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	sub al,30h
	mov diandig1,al
	int 21h
	sub al,30h
	mov diandig2,al
	mov dx,offset mesn
	mov ah,09h
	int 21h 
	mov ah,01h
	int 21h
	sub al,30h
	mov mesndig1,al
	int 21h	
	sub al,30h							;30
	mov mesndig2,al
	mov dx,offset anac
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	sub al,30h
	mov anacdig1,al
	int 21h
	sub al,30h
	mov anacdig2,al
	int 21h
	sub al,30h
	mov anacdig3,al
	int 21h
	sub al,30h
	mov anacdig4,al
	

digitocuatro:
	mov ah,aactdig4
	mov al,anacdig4
	sub ah,al
	js pideunodigcuatro
	mov edaddig4,ah
	jmp digitotres

pideunodigcuatro:
	mov ah,aactdig4
	add ah,10
	mov aactdig4,ah
	dec aactdig3
	js pideunodigtres
	jmp digitocuatro					;ver dps si ocurre porq hay un salto condicional 
	

digitotres:
	mov ah,aactdig3
	mov al,anacdig3
	sub ah,al
	js pideunodigtres
	mov edaddig3,ah
	jmp digitodos

pideunodigtres:
	mov ah,aactdig3
	add ah,10
	mov aactdig3,ah
	dec aactdig2
	js pideunodigdos
	jmp digitocuatro

digitodos:
	mov ah,aactdig2
	mov al,anacdig2
	sub ah,al
	js pideunodigdos
	mov edaddig2,ah
	jmp digitouno

pideunodigdos:
	mov ah,aactdig2
	add ah,10
	mov aactdig2,ah
	dec aactdig1
	js noposible
	jmp digitocuatro

digitouno:
	mov ah,aactdig1
	mov al,anacdig1
	sub ah,al
	js noposible
	mov edaddig1,ah
	call mes

muestra:
	mov dx,offset mosedad
	mov ah,09h
	int 21h
	mov ah,02h
	mov dl,edaddig1
	add dl,30h
	int 21h
	mov dl,edaddig2
	add dl,30h
	int 21h
	mov dl,edaddig3
	add dl,30h
	int 21h 
	mov dl,edaddig4
	add dl,30h
	int 21h
	mov dx,offset mosedadfcd
	mov ah,09h
	int 21h
	call fin

noposible:
	mov dx,offset imp
	mov ah,09h
	int 21h
	call fin
	
mes:
	mov al,mesndig1
	mov ah,mesadig1 
	xor ah,al
	jz decigual
	mov ah,mesadig1
	sub ah,al
	jns yacumplioA
	js nocumple
	call muestra
									;40

decigual:	
	mov ah,mesadig2
	mov al,mesndig2
	xor ah,al
	jz mismomes
	mov ah,mesadig2
	sub ah,al
	jns yacumplioa
	call nocumple
	ret

yacumplioA :
	mov dx,offset yacumplio
	mov ah,09h							;50
	int 21h
	jmp muestra
	call fin

fin:
	mov ax,4c00h
	int 21h
	ret

mostrar:
	mov dx,ax
	mov ax,02h
	int 21h	
	ret


mismomes:
	mov ah,diaadig1
	mov al,diandig1
	xor ah,al
	jz felizcumple
	mov ah,diaadig1
	sub ah,al
	jns yacumplioa
	js nocumple
	
	

nocumple:
	mov dx,offset todnoc
	mov ah,09h
	int 21h
	dec edaddig4
	js digtres
	jmp muestra
	call fin

digtres:
	mov edaddig4,39h
	dec edaddig3
	js digdos
	jmp muestra

digdos:
	mov edaddig3,39h
	dec edaddig2
	js diguno
	jmp muestra

diguno:
	mov edaddig2,39h
	dec edaddig1
	js noposible
	jmp muestra



felizcumple:
	mov dx,offset fc
	mov ah,09h
	int 21h
	mov dx,offset mosedadfc
	int 21h
	mov ah,02h
	mov dl,edaddig1
	add dl,30h
	int 21h
	mov dl,edaddig2
	add dl,30h
	int 21h
	mov dl,edaddig3
	add dl,30h
	int 21h 
	mov dl,edaddig4
	add dl,30h
	int 21h
	mov dx,offset mosedadfcd
	mov ah,09h
	int 21h
	call fin
	


end start

	
	
	