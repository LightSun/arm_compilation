/*
;这是一个汇编文件
;YASM的注释风格使用分号形式

;global MyASMTest
;section .text

;MyASMTest:
;    sub     edi, esi
;    mov     eax, edi
;    ret
*/

.section .text,"xx"
.global MyASMTest
MyASMTest:
    ADD r0, r0, r1
    MOV pc, lr

.end