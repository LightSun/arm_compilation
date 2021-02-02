
//https://azeria-labs.com/arm-conditional-execution-and-branching-part-6/

/* lr(r14）的作用问题，这个lr一般来说有两个作用：
1.当使用bl或者blx跳转到子过程的时候，r14保存了返回地址，可以在调用过程结尾恢复。
2.异常中断发生时，这个异常模式特定的物理R14被设置成该异常模式将要返回的地址。*/



.global main

main:
        mov     r0, #2     /* setting up initial variable */
        cmp     r0, #3     /* comparing r0 to number 3. Negative bit get's set to 1 */
        addlt   r0, r0, #1 /* increasing r0 IF it was determined that it is smaller (lower than) number 3 */
        cmp     r0, #3     /* comparing r0 to number 3 again. Zero bit gets set to 1. Negative bit is set to 0 */
        addlt   r0, r0, #1 /* increasing r0 IF it was determined that it is smaller (lower than) number 3 */
        bx      lr

        /* like c
        int main() {
            int a = 2;
            if(a < 3){
               a++;
            }
            if(a < 3){
               a++;
            }
            return a;
        }
        */

//---------------------------------------------------------
.global main2

main2:
        mov     r0, #0     /* setting up initial variable a */
loop:
        cmp     r0, #4     /* checking if a==4 */
        beq     end        /* proceeding to the end if a==4 */
        add     r0, r0, #1 /* increasing a by 1 if the jump to the end did not occur */
        b loop             /* repeating the loop */
end:
        bx lr              /* THE END */

        /*
        like
        int main2() {
           int a = 0;
           while(a < 4) {
           a= a+1;
           }
           return a;
        }
        */
