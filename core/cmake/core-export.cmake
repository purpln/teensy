set(MD5_INFILE "current_path.txt")

file(WRITE ${CMAKE_CURRENT_LIST_DIR}/${MD5_INFILE} ${CMAKE_CURRENT_LIST_DIR})
execute_process(COMMAND ${CMAKE_COMMAND}
    -E md5sum
    ${CMAKE_CURRENT_LIST_DIR}/${MD5_INFILE}
    OUTPUT_VARIABLE MD5_SUM
)
string(SUBSTRING ${MD5_SUM} 0 32 MD5_SUM)

if(WIN32)
    execute_process(COMMAND ${CMAKE_COMMAND}
        -E write_regv
        "HKEY_CURRENT_USER\\Software\\Kitware\\CMake\\Packages\\Core\;${MD5_SUM}"
        "${CMAKE_CURRENT_LIST_DIR}"
)
else()
    file(WRITE $ENV{HOME}/.cmake/packages/Core/${MD5_SUM} ${CMAKE_CURRENT_LIST_DIR})
endif()

if(WIN32)
    message("HKEY_CURRENT_USER\\Software\\Kitware\\CMake\\Packages\\Core")
else()
    message("~/.cmake/packages/Core")
endif()

file(REMOVE ${CMAKE_CURRENT_LIST_DIR}/${MD5_INFILE})