cmake_minimum_required(VERSION 3.20)

project(usb C)

file(GLOB usb_sources "sources/*.c")

add_library(usb STATIC ${usb_sources})

target_include_directories(usb PUBLIC include)