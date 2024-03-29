@frozen
public struct Bool {
    @usableFromInline
    internal var _value: Builtin.Int1
    
    @_transparent
    public init() {
        let zero: Int8 = 0
        self._value = Builtin.trunc_Int8_Int1(zero._value)
    }
    
    @_transparent
    @usableFromInline
    internal init(_ value: Builtin.Int1) {
        self._value = value
    }
    
    @inlinable
    public init(_ value: Bool) {
        self = value
    }
}

extension Bool: _ExpressibleByBuiltinBooleanLiteral {
    @_transparent
    public init(_builtinBooleanLiteral value: Builtin.Int1) {
        self._value = value
    }
}

extension Bool: ExpressibleByBooleanLiteral {
    @_transparent
    public init(booleanLiteral value: Bool) {
        self = value
    }
}

extension Bool {
    @_transparent
    public func _getBuiltinLogicValue() -> Builtin.Int1 {
        return _value
    }
}

extension Bool: Equatable {
    @_transparent
    public static func == (lhs: Bool, rhs: Bool) -> Bool {
        return Bool(Builtin.cmp_eq_Int1(lhs._value, rhs._value))
    }
}

extension Bool {
    @_transparent
    public static prefix func ! (_ value: Bool) -> Bool {
        return Bool(Builtin.xor_Int1(value._value, true._value))
    }
}

extension Bool: CustomStringConvertible {

}

extension Bool: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine((self ? 1 : 0) as UInt8)
    }
}

extension Bool: LosslessStringConvertible {

}

extension Bool {
    @_transparent
    @inline(__always)
    public static func && (lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool {
        return lhs ? try rhs() : false
    }
    
    @_transparent
    @inline(__always)
    public static func || (lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool {
        return lhs ? true : try rhs()
    }
}

extension Bool {
    @inlinable
    public mutating func toggle() {
        self = !self
    }
}