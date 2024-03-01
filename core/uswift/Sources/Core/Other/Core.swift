@_transparent
@usableFromInline
internal func conditionallyUnreachable() -> Never {
    Builtin.conditionallyUnreachable()
}

@inlinable
@inline(__always)
internal func trueAfterDiagnostics() -> Builtin.Int1 {
    return true._value
}

@_transparent
public func precondition(_ condition: @autoclosure () -> Bool, _: StaticString, file _: StaticString = #file, line _: UInt = #line) {
    let error = !condition()
    Builtin.condfail_message(error._value, StaticString("precondition failure").unsafeRawPointer)
}

@_transparent
@usableFromInline
internal func preconditionFailure(_ message: StaticString = StaticString(), file: StaticString = #file, line: UInt = #line) -> Never {
    precondition(false, message, file: file, line: line)
    conditionallyUnreachable()
}

@_transparent
@usableFromInline
internal func == (lhs: Builtin.NativeObject, rhs: Builtin.NativeObject) -> Bool {
    return unsafeBitCast(lhs, to: Int.self) == unsafeBitCast(rhs, to: Int.self)
}

@usableFromInline @_transparent
internal func != (lhs: Builtin.NativeObject, rhs: Builtin.NativeObject) -> Bool {
    return !(lhs == rhs)
}

@usableFromInline @_transparent
internal func == (lhs: Builtin.RawPointer, rhs: Builtin.RawPointer) -> Bool {
    return unsafeBitCast(lhs, to: Int.self) == unsafeBitCast(rhs, to: Int.self)
}

@_transparent
@usableFromInline
internal func != (lhs: Builtin.RawPointer, rhs: Builtin.RawPointer) -> Bool {
    return !(lhs == rhs)
}

@_transparent
@inlinable
public func == (t0: Any.Type?, t1: Any.Type?) -> Bool {
    switch (t0, t1) {
    case (.none, .none):
        return true
    case let (.some(ty0), .some(ty1)):
        return Bool(Builtin.is_same_metatype(ty0, ty1))
    default: return false
    }
}

@_transparent
@inlinable
public func != (t0: Any.Type?, t1: Any.Type?) -> Bool {
    return !(t0 == t1)
}
/*
@_alwaysEmitIntoClient
@_transparent
public func _specialize<T, U>(_ x: T, for: U.Type) -> U? {
    guard T.self == U.self else {
        return nil
    }
    let result: U = Builtin.reinterpretCast(x)
    return result
}
*/
@_transparent
@_semantics("typechecker.type(of:)")
public func type<T, Metatype>(of value: T) -> Metatype {
    Builtin.staticReport(trueAfterDiagnostics(), true._value, StaticString("internal consistency error: 'type(of:)' operation failed to resolve").unsafeRawPointer)
    Builtin.unreachable()
}
/*
@_alwaysEmitIntoClient
@_transparent
@_semantics("typechecker.withoutActuallyEscaping(_:do:)")
public func withoutActuallyEscaping<ClosureType, ResultType, Failure>(_ closure: ClosureType, do body: (_ escapingClosure: ClosureType) throws(Failure) -> ResultType) throws(Failure) -> ResultType {
    Builtin.staticReport(trueAfterDiagnostics(), true._value, StaticString("internal consistency error: 'withoutActuallyEscaping(_:do:)' operation failed to resolve").unsafeRawPointer)
    Builtin.unreachable()
}
*/

@_transparent
public func unsafeReferenceCast<T, U>(_ x: T, to: U.Type) -> U {
    return Builtin.castReference(x)
}

@_transparent
public func unsafeDowncast<T: AnyObject>(_ x: AnyObject, to type: T.Type) -> T {
    precondition(x is T, "invalid unsafeDowncast")
    return Builtin.castReference(x)
}

@inlinable
@_transparent
public func unsafeBitCast<T, U>(_ x: T, to type: U.Type) -> U {
    precondition(MemoryLayout<T>.size == MemoryLayout<U>.size, "Can't unsafeBitCast between types of different sizes")
    return Builtin.reinterpretCast(x)
}

@_silgen_name("swift_getFunctionFullNameFromMangledName")
public func _getFunctionFullNameFromMangledNameImpl(_ mangledName: UnsafePointer<UInt8>, _ mangledNameLength: UInt) -> (UnsafePointer<UInt8>, UInt)

@_silgen_name("swift_getTypeName")
public func _getTypeName(_ type: Any.Type, qualified: Bool) -> (UnsafePointer<UInt8>, Int)

@_silgen_name("swift_getMangledTypeName")
public func _getMangledTypeName(_ type: Any.Type) -> (UnsafePointer<UInt8>, Int)

@_silgen_name("swift_stdlib_getTypeByMangledNameUntrusted")
internal func _getTypeByMangledNameUntrusted(_ name: UnsafePointer<UInt8>, _ nameLength: UInt) -> Any.Type?

@_silgen_name("swift_getTypeByMangledNameInEnvironment")
public func _getTypeByMangledNameInEnvironment(_ name: UnsafePointer<UInt8>, _ nameLength: UInt, genericEnvironment: UnsafeRawPointer?, genericArguments: UnsafeRawPointer?) -> Any.Type?

@_silgen_name("swift_getTypeByMangledNameInContext")
public func _getTypeByMangledNameInContext(_ name: UnsafePointer<UInt8>, _ nameLength: UInt, genericContext: UnsafeRawPointer?, genericArguments: UnsafeRawPointer?) -> Any.Type?

@_alwaysEmitIntoClient
@_semantics("no_performance_analysis")
public func _unsafePerformance<T>(_ c: () -> T) -> T {
    return c()
}

@usableFromInline
@_alwaysEmitIntoClient
@inline(__always)
func _rethrowsViaClosure(_ fn: () throws -> ()) rethrows {
    try fn()
}