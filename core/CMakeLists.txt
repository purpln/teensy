cmake_minimum_required(VERSION 3.20)

project(Core VERSION 1.0.0)

set(CMAKE_TOOLCHAIN_FILE cmake/toolchains/arm-none-eabi.cmake)
set(root ${CMAKE_CURRENT_LIST_DIR})

include(boards/boards.cmake)
include(cmake/toolchains/common.cmake)

file(GLOB lib_sources lib/sources/*.c)
add_library(Core STATIC ${sources} ${lib_sources})
target_include_directories(Core PUBLIC ${path}/include lib/include)

add_subdirectory(uswift)
target_link_libraries(Core PRIVATE swiftCore)

install(
    TARGETS Core
    EXPORT ${TARGETS_EXPORT_NAME}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)