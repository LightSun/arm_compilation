
 .text

    .align 4
    .global add_float_neon2
    .type add_float_neon2, %function

add_float_neon2:

.L_loop:
    ld1     {v0.4s}, [x1], #16
    ld1     {v1.4s}, [x2], #16
    fadd    v0.4s, v0.4s, v1.4s
    subs x3, x3, #4
    st1  {v0.4s}, [x0], #16
    bgt .L_loop

    ret
//arm64
    //x0-x7 用于传递子程序参数和结果，使用时不需要保存，多余参数采用堆栈传递，64位返回结果采用X0表示，128位返回结果采用X1:X0表示。
    //X9~X15：临时寄存器，使用时不需要保存。
   // X19~X28：临时寄存器，使用时必须保存。
   // X29：帧指针寄存器，用于连接栈帧，使用时需要保存。
   // X30：链接寄存器LR
   // X31：堆栈指针寄存器SP或零寄存器ZXR