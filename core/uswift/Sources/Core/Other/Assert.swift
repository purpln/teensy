// COMPILER_INTRINSIC

@_transparent
public func _diagnoseUnexpectedNilOptional(_filenameStart: Builtin.RawPointer,
                                           _filenameLength: Builtin.Word,
                                           _filenameIsASCII: Builtin.Int1,
                                           _line: Builtin.Word,
                                           _isImplicitUnwrap: Builtin.Int1) {
    let file = StaticString(_start: _filenameStart, utf8CodeUnitCount: _filenameLength, isASCII: _filenameIsASCII)
    if Bool(_isImplicitUnwrap) {
        preconditionFailure("Unexpectedly found nil while implicitly unwrapping an Optional value", file: file, line: UInt(_line))
    } else {
        preconditionFailure("Unexpectedly found nil while unwrapping an Optional value", file: file, line: UInt(_line))
    }
}

@usableFromInline
@inline(never)
@_semantics("programtermination_point")
internal func _assertionFailure(_ prefix: StaticString, _ message: StaticString, flags: UInt32) -> Never {
    Builtin.int_trap()
}

@usableFromInline
@inline(never)
@_semantics("programtermination_point")
internal func _fatalErrorMessage(_ prefix: StaticString, _ message: StaticString, file: StaticString, line: UInt, flags: UInt32) -> Never {
    preconditionFailure(message, file: file, line: line)
}

public func _undefined<T>(_ message: @autoclosure () -> StaticString = StaticString(), file: StaticString = #file, line: UInt = #line) -> T {
    preconditionFailure(message(), file: file, line: line)
}

@inline(never)
@usableFromInline
internal func _diagnoseUnexpectedEnumCaseValue<SwitchedValue, RawValue>(type: SwitchedValue.Type, rawValue: RawValue) -> Never {
    Builtin.int_trap()
}

@inline(never)
@usableFromInline
internal func _diagnoseUnexpectedEnumCase<SwitchedValue>(type: SwitchedValue.Type) -> Never {
    Builtin.int_trap()
}

@_transparent
public func _convertPointerToPointerArgument<FromPointer: _Pointer, ToPointer: _Pointer>(_ from: FromPointer) -> ToPointer {
    return ToPointer(from._rawValue)
}

@_transparent
public func _convertInOutToPointerArgument<ToPointer: _Pointer>(_ from: Builtin.RawPointer) -> ToPointer {
    return ToPointer(from)
}
/*
@_transparent
public func _convertConstArrayToPointerArgument<FromElement, ToPointer: _Pointer>(_ arr: [FromElement]) -> (AnyObject?, ToPointer) {
    let (owner, opaquePointer) = arr._cPointerArgs()
    
    let validPointer: ToPointer
    if let addr = opaquePointer {
        validPointer = ToPointer(addr._rawValue)
    } else {
        let lastAlignedValue = ~(MemoryLayout<FromElement>.alignment - 1)
        let lastAlignedPointer = UnsafeRawPointer(bitPattern: lastAlignedValue)!
        validPointer = ToPointer(lastAlignedPointer._rawValue)
    }
    return (owner, validPointer)
}

@_transparent
public func _convertMutableArrayToPointerArgument<FromElement, ToPointer: _Pointer>(_ a: inout [FromElement]) -> (AnyObject?, ToPointer) {
    a.reserveCapacity(0)
    preconditionFailure(a._baseAddressIfContiguous != nil || a.isEmpty)
    return _convertConstArrayToPointerArgument(a)
}
*/