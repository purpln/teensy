list(APPEND command
    ${CMAKE_Swift_COMPILER}
    -target ${TARGET_Swift}
    -parse-as-library
    ${TOOLCHAIN_Swift_FLAGS}
    -I ${CMAKE_BINARY_DIR}/swift -c ${CMAKE_CURRENT_SOURCE_DIR}/test.swift -o test.o
)
list(JOIN command " " command)

string(REPLACE " " ";" command ${command})

add_custom_command(OUTPUT test.o COMMAND ${command} WORKING_DIRECTORY ${CMAKE_BINARY_DIR})

add_custom_target(test DEPENDS test.o)
add_dependencies(test swiftCore)
add_dependencies(test swiftOnoneSupport)