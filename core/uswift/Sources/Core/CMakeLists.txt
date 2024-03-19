file(GLOB sources *.swift */*.swift */*/*.swift)
add_library(swiftCore ${sources})
set_target_properties(swiftCore PROPERTIES Swift_MODULE_NAME Swift)
target_compile_options(swiftCore PRIVATE
    -parse-stdlib
    "SHELL:-Xfrontend -enable-resilience"
    "SHELL:-enable-experimental-feature Extern"
    "SHELL:-enable-experimental-feature NoncopyableGenerics"
    "SHELL:-enable-experimental-feature NonescapableTypes"
)
target_link_libraries(swiftCore PRIVATE swiftRuntime)
target_link_options(swiftCore PRIVATE "SHELL:-Xclang-linker -nostdlib")
