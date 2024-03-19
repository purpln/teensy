### Download
ninja & cmake,
[llvm Toolchain](https://github.com/ARM-software/LLVM-embedded-toolchain-for-Arm/releases),
[Swift snapshot](https://www.swift.org/download/)

### Set up paths in
project/CMakeLists.txt (project example)
```CMake
set(llvm <toolchain path>)
set(swift <snapshot swiftc path>)

find_package(Core 1.0.0 CONFIG REQUIRED PATHS <core from this repo path>)
```

### Build
```shell
cd ~/teensy/project
cmake -B .build -G Ninja -S .
ninja -C .build
```

### Binary
app.hex

### Standart library features support
| Core | Status | Priority |
|------|:------:|---------:|
| ExpressibleByFloatLiteral | full | |
| ExpressibleByIntegerLiteral | full | |
| ExpressibleByStringLiteral | full | |
| ExpressibleByNilLiteral | full | |
| ExpressibleByArrayLiteral | none | highest |
| ExpressibleByDictionaryLiteral | none | average |
| RawRepresentable | full | |
| MemoryLayout | partial | |

| Protocols | Status | Priority |
|-----------|:------:|---------:|
| Equatable | full | |
| Comparable | full | |
| Strideable | full | |
| Error | minimum | |
| Hashable | minimum | |
| Identifiable | minimum | |
| OptionSet | partial | |
| SetAlgebra | none | highest |
| CustomStringConvertible | minimum | |
| LosslessStringConvertible | minimum | |
| AdditiveArithmetic | full | |
| Numeric | mostly | highest |
| SignedNumeric | full | |
| BinaryInteger | partial | highest |
| FixedWidthInteger | mostly | average |
| UnsignedInteger | full | |
| SignedInteger | full | |
| FloatingPoint | partial | average |
| BinaryFloatingPoint | partial | average |
| RangeExpression | full | |
| Collection | partial | |
| IteratorProtocol | full | |
| Sequence | partial | |
| RandomAccessCollection | none | low |
| BidirectionalCollection | none | low |

| Values | Status | Priority |
|--------|:------:|---------:|
| Bool | partial | |
| Optional | partial | |
| Int | partial | |
| Int8 | partial | |
| Int16 | partial | |
| Int32 | partial | |
| Int64 | partial | |
| UInt | partial | |
| UInt8 | partial | |
| UInt16 | partial | |
| UInt32 | partial | |
| UInt64 | partial | |
| Float | partial | |
| Double | partial | |
| String | none | average |
| StaticString | partial | |
| Array | none | highest |
| Set | none | average |
| Range | partial | |
| ClosedRange | partial | |
| Result | none | |

| Collection | Status | Priority |
|------------|:------:|---------:|
| Slice | none | high |

| Pointer | Status | Priority |
|---------|:------:|---------:|
| _Pointer | partial | |
| OpaquePointer | partial | |
| UnsafeMutablePointer | partial | |
| UnsafeMutableRawPointer | partial | |
| UnsafePointer | partial | |
| UnsafeRawPointer | partial | |
