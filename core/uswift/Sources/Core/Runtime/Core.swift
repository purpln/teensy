@_silgen_name("swift_errorInMain")
internal func errorInMain(_ error: Error) {
    Builtin.int_trap()
}

@_silgen_name("swift_willThrow")
public func swift_willThrow() throws {

}

@_transparent
public func precondition(_ condition: @autoclosure () -> Bool, _: StaticString, file _: StaticString = #file, line _: UInt = #line) {
    let error = !condition()
    Builtin.condfail_message(error._value, StaticString("precondition failure").unsafeRawPointer)
}


@_transparent
@usableFromInline
internal func conditionallyUnreachable() -> Never {
    Builtin.conditionallyUnreachable()
}

@_transparent
@usableFromInline
internal func preconditionFailure(_ message: StaticString = StaticString(), file: StaticString = #file, line: UInt = #line) -> Never {
    precondition(false, message, file: file, line: line)
    conditionallyUnreachable()
}

@inlinable
@inline(__always)
internal func minAllocationAlignment() -> Int {
    return 16
}

@inlinable
@_transparent
public func unsafeBitCast<T, U>(_ x: T, to type: U.Type) -> U {
    precondition(MemoryLayout<T>.size == MemoryLayout<U>.size, "Can't unsafeBitCast between types of different sizes")
    return Builtin.reinterpretCast(x)
}

/*
@_extern(c, "arc4random_buf")
func arc4random_buf(buf: UnsafeMutableRawPointer, nbytes: Int)

public func swift_stdlib_random(_ buf: UnsafeMutableRawPointer, _ nbytes: Int) {
    arc4random_buf(buf: buf, nbytes: nbytes)
}
*/