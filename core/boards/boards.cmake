if(${board} STREQUAL "teensy-4.1")

    set(path ${CMAKE_CURRENT_LIST_DIR}/teensy/4.1)
    set(linker ${CMAKE_CURRENT_LIST_DIR}/teensy/4.1)

    include(${path}/imxrt1062.cmake)

    file(GLOB sources ${path}/sources/*.c ${path}/usb/sources/*.c)
    include_directories(${path}/include ${path}/usb/include)
    
elseif(${board} STREQUAL "rpi-pico")

    set(path ${CMAKE_CURRENT_LIST_DIR}/raspberry/pico)
    set(linker ${CMAKE_CURRENT_LIST_DIR})

    include(${path}/rp2040.cmake)

    file(GLOB sources ${path}/sources/*.c)
    include_directories(${path}/include)

else()
    message(FATAL_ERROR "no board")
endif()