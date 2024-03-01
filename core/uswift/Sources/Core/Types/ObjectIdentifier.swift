@frozen
public struct ObjectIdentifier: Sendable {
    @usableFromInline
    internal let _value: Builtin.RawPointer
    
    @inlinable
    public init<Object: AnyObject>(_ x: Object) {
        self._value = Builtin.bridgeToRawPointer(x)
    }
    
    @inlinable
    public init<Object>(_ x: Object.Type) {
        self._value = unsafeBitCast(x, to: Builtin.RawPointer.self)
    }
}

extension ObjectIdentifier: Equatable {
    @inlinable
    public static func == (x: ObjectIdentifier, y: ObjectIdentifier) -> Bool {
        return Bool(Builtin.cmp_eq_RawPointer(x._value, y._value))
    }
}

extension ObjectIdentifier: Comparable {
    @inlinable
    public static func < (lhs: ObjectIdentifier, rhs: ObjectIdentifier) -> Bool {
        return UInt(bitPattern: lhs) < UInt(bitPattern: rhs)
    }
}