//
// Created by Administrator on 2020/9/29 0029.
//

#include "arm_test.h"

//
// Created by Zenny Chen on 2017/10/27.
//

#include <jni.h>
#include <stdio.h>
#include <string.h>

/*
 * 测试内联汇编，分别根据AArch32架构以及AArch64架构来实现一个简单的减法计算
 * @param a 被减数
 * @param b 减数
 * @return 减法得到的差值
 */
// int __attribute__((naked, pure)) MyASMTest(int a, int b);

extern void add_float_neon2(float* dst, float* src1, float* src2, int count);

JNICALL jint Java_com_heaven7_android_compilation_ArmCompilation_testSub(JNIEnv *env, jclass clazz, jint a , jint b){
    //return MyASMTest(a, b);
    float result[3];
    float b1[3] = {4, 5, 6};
    float c1[3] = {7, 8, 9};
    add_float_neon2(result, b1, c1, 3);
    return 0;
}
