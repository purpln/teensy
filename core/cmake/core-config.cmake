cmake_path(GET CMAKE_CURRENT_LIST_DIR PARENT_PATH PROJECT_DIR)

include(${PROJECT_DIR}/cmake/toolchains/arm-none-eabi.cmake)
include(${PROJECT_DIR}/boards/boards.cmake)
include(${PROJECT_DIR}/cmake/toolchains/common.cmake)

add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/../ ${CMAKE_CURRENT_BINARY_DIR}/Core)