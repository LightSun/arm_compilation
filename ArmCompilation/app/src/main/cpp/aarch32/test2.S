

// Arm v7-A/Arm v8-A AArch32版本
    .text
    .syntax unified

    .align 4
    .global add_float_neon2
    .type add_float_neon2, %function
    .thumb
    .thumb_func

add_float_neon2:
.L_loop:
    vld1.32  {q0}, [r1]!
    vld1.32  {q1}, [r2]!
    vadd.f32 q0, q0, q1
    subs r3, r3, #4
    vst1.32  {q0}, [r0]!
    bgt .L_loop

    bx lr