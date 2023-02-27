cmake_minimum_required(VERSION 3.12)
set(PICO_SDK_PATH "/home/sonny/pico/pico-sdk")
set(PICO_BOARD "pico_w")
include("${PICO_SDK_PATH}/external/pico_sdk_import.cmake")

project(ble_2way C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(PICO_PLATFORM rp2040)
set(PICO_COMPILER "pico_arm_gcc")
set(CMAKE_BUILD_TYPE Release)
pico_sdk_init()
add_executable(ble_2way
    ble_2way.c
	)
target_link_libraries(ble_2way
    pico_stdlib
    pico_btstack_ble
    pico_btstack_cyw43
    pico_cyw43_arch_none
    )
target_include_directories(ble_2way PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
    )
pico_btstack_make_gatt_header(ble_2way PRIVATE "${CMAKE_CURRENT_LIST_DIR}/mygatt.gatt")
pico_add_extra_outputs(ble_2way)
