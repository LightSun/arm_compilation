
 //add_float_neon2(float* dst, float* src1, float* src2, int count)
 //(x0, x1 , x2, x3)
 .text

    .align 4
    .global add_float_neon2
    .type add_float_neon2, %function

add_float_neon2:

.L_loop:
    ld1     {v0.4s}, [x1], #16   //加载x1指向的存储单元的低32位 加载到v0寄存器
    ld1     {v1.4s}, [x2], #16
    fadd    v0.4s, v0.4s, v1.4s  //浮点型加法
    subs x3, x3, #4              //自减
    st1  {v0.4s}, [x0], #16      //将寄存器v0的低32位存储到x0处
    bgt .L_loop                  //跳转, 类似goto

    ret
//arm64
    //x0-x7 用于传递子程序参数和结果，使用时不需要保存，多余参数采用堆栈传递，64位返回结果采用X0表示，128位返回结果采用X1:X0表示。
    //X9~X15：临时寄存器，使用时不需要保存。
   // X19~X28：临时寄存器，使用时必须保存。
   // X29：帧指针寄存器，用于连接栈帧，使用时需要保存。
   // X30：链接寄存器LR
   // X31：堆栈指针寄存器SP或零寄存器ZXR

   /** https://blog.csdn.net/SoaringLee_fighting/article/details/81906495

   ld1 {v20.8H, v21.8H}, [x1]  @ 从x1指向的存储单元位置一次性加载128*2位数据到v20和v21中
   ld1 {v1.8B},	[x1],	x2  @ 从x1指向的存储单元位置加载64位数据到v1的低64位中，然后x1=x1+x2
   ld1	{v18.S}[0],	[x0],	x1  @ 将x0地址里面的数据取32位加载到v18的最低32位，然后x0=x0+x1
   ld1r {v30.8H},	[x1]		@ 从x1地址中以16位为单位取128位加载到v30中。

   st1	{v30.8H},	[x1],	#16	@ 将 寄存器v30中128位数据存储到x1地址处，然后x1=x1+16
   st1	{v0.S}[0],	[x0],	x2	@ 将 寄存器v0的低32位数据存储到x0地址处吗，然后x0=x0+x2

   */