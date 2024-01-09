add_library(swift_Concurrency
  _Concurrency.swift
)
set_target_properties(swift_Concurrency PROPERTIES Swift_MODULE_NAME _Concurrency)
target_compile_options(swift_Concurrency PRIVATE -parse-stdlib "SHELL:-Xfrontend -enable-resilience")
target_link_libraries(swift_Concurrency PUBLIC swiftCore)
target_link_options(swift_Concurrency PRIVATE "SHELL:-Xclang-linker -nostdlib")
