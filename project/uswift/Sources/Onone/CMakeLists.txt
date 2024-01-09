add_library(swiftOnoneSupport
  SwiftOnoneSupport.swift
)
set_target_properties(swiftOnoneSupport PROPERTIES Swift_MODULE_NAME SwiftOnoneSupport)
target_compile_options(swiftOnoneSupport PRIVATE -parse-stdlib "SHELL:-Xfrontend -enable-resilience")
target_link_libraries(swiftOnoneSupport PUBLIC swiftCore)
target_link_options(swiftOnoneSupport PRIVATE "SHELL:-Xclang-linker -nostdlib")
