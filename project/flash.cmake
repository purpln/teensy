set_target_properties(app PROPERTIES OUTPUT_NAME "app.elf")
add_custom_command(TARGET app POST_BUILD COMMAND ${CMAKE_OBJCOPY_BIN} -O ihex "app.elf" "${CMAKE_SOURCE_DIR}/app.hex")