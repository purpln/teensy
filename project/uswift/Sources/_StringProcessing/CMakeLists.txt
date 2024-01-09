add_library(swift_StringProcessing
  _StringProcessing.swift
)
set_target_properties(swift_StringProcessing PROPERTIES Swift_MODULE_NAME _StringProcessing)
target_compile_options(swift_StringProcessing PRIVATE -parse-stdlib "SHELL:-Xfrontend -enable-resilience")
target_link_libraries(swift_StringProcessing PUBLIC swiftCore)
target_link_options(swift_StringProcessing PRIVATE "SHELL:-Xclang-linker -nostdlib")
