
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
    subs x3, x3, #4              //自减 x3 -= 4(字节)
    st1  {v0.4s}, [x0], #16      //将寄存器v0的低32位存储到x0处, 然后x0 += 16
    bgt .L_loop                  //跳转, 类似goto

    ret

    /**
     //like
     void add_float_c(float* dst, float* src1, float* src2, int count)
     {

          int i;

          for (i = 0; i < count; i++)

              dst[i] = src1[i] + src2[i];

     }
     */
//arm64
//w0-w21
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

   ld1   {v0.16b, v1.16b}, [%0], #32

   st1	{v30.8H},	[x1],	#16	@ 将 寄存器v30中128位数据存储到x1地址处，然后x1=x1+16
   st1	{v0.S}[0],	[x0],	x2	@ 将 寄存器v0的低32位数据存储到x0地址处吗，然后x0=x0+x2

lsl #3 表示左移3位
add         x3, x3, x0, lsl #3 @ 表示 x3 += x0 * 2^3
   */

   /**
   汇编指令

   下面介绍ARM64经常用到的汇编指令

   MOV X1，X0 ; 将寄存器X0的值传送到寄存器X1

   ADD X0，X1，X2 ; 寄存器X1和X2的值相加后传送到X0

   SUB X0，X1，X2 ; 寄存器X1和X2的值相减后传送到X0

   AND X0，X0，#0xF ; X0的值与0xF相位与后的值传送到X0

   ORR X0，X0，#9 ; X0的值与9相或后的值传送到X0

   EOR X0，X0，#0xF ; X0的值与0xF相异或后的值传送到X0

   LDR X5，[X6，#0x08] ；X6寄存器加0x08的和的地址值内的数据传送到X5

   STR X0, [SP, #0x8] ；X0寄存器的数据传送到SP+0x8地址值指向的存储空间

   STP x29, x30, [sp, #0x10] ; 入栈指令

   LDP x29, x30, [sp, #0x10] ; 出栈指令

   CBZ ; 比较（Compare），如果结果为零（Zero）就转移（只能跳到后面的指令）

   CBNZ ; 比较，如果结果非零（Non Zero）就转移（只能跳到后面的指令）

   CMP ; 比较指令，相当于SUBS，影响程序状态寄存器

   CPSR B/BL ; 绝对跳转#imm， 返回地址保存到LR（X30）

   RET ; 子程序返回指令，返回地址默认保存在LR（X30）
   */