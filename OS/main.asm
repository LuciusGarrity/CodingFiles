[org 0x7c00]
[bits 16]

section .text
	
	global main

main:
mov si, LOADING
call printf

cli
jmp 0x0000:ZeroSeg
ZeroSeg:
	xor ax, ax
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov gs, ax
	mov sp, main
	cld
sti

;xor ax, ax
mov dl, 0x80
int 0x13

;mov al, 1
;mov cl, 2
;call readDisk

mov ax, 0x2400
int 0x15

call testA20

;jmp sTwo

jmp $

%include "./printf.asm"
%include "./readDisk.asm"
%include "./printh.asm"
%include "./testA20.asm"
		
LOADING: db 'Loading...',0x0a,0x0d,0
TEST_STR: db 'Second Sector Loaded.',0x0a, 0x0d, 0
DISK_ERR_MSG: db 'Error Loading Disk.', 0x0a, 0x0d, 0

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55

sTwo:
	mov si, TEST_STR
	call printf
	ret

times 512 db 0