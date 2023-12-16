if(${board} STREQUAL "teensy-4.1")
    include(${CMAKE_CURRENT_LIST_DIR}/teensy/imxrt1062.cmake)

    file(GLOB sources ${CMAKE_CURRENT_LIST_DIR}/teensy/sources/*.c)

    set(path ${CMAKE_CURRENT_LIST_DIR}/teensy)
    set(linker ${CMAKE_CURRENT_LIST_DIR})

    include_directories(${path}/include)
else()
    message(FATAL_ERROR "no board")
endif()