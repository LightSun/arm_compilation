cmake_minimum_required(VERSION 3.4.1)

#asm 用clang编译。  nasm 用yasm编译
enable_language(ASM)

include_directories(src/main/cpp/include)

#aux_source_directory(src/main/cpp/src SRC_study)
aux_source_directory(src/main/cpp/libyuv SRC_libyuv)

add_library(
        arm_study
        SHARED
        src/main/cpp/aarch64/test2.S
        src/main/cpp/arm_test.c
        #${SRC_libyuv}
)
find_library( # Sets the name of the path variable.
        log-lib

        # Specifies the name of the NDK library that
        # you want CMake to locate.
        log)

target_link_libraries(
        arm_study
        ${log-lib}
)