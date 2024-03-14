@frozen
public struct UInt32: FixedWidthInteger, UnsignedInteger {
    public typealias Magnitude = UInt32
    
    @usableFromInline
    internal var _value: Builtin.Int32
    
    @_transparent
    public init(_ _value: Builtin.Int32) {
        self._value = _value
    }
    
    @_transparent
    public static func & (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.and_Int32(lhs._value, rhs._value))
    }

    @_transparent
    public static func | (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.or_Int32(lhs._value, rhs._value))
    }

    @_transparent
    public static func ^ (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.xor_Int32(lhs._value, rhs._value))
    }

    @_transparent
    public static var bitWidth: Int { return 32 }
}

extension UInt32: _ExpressibleByBuiltinIntegerLiteral {
    @_transparent
    public init(_builtinIntegerLiteral value: Builtin.IntLiteral) {
        _value = Builtin.s_to_u_checked_trunc_IntLiteral_Int32(value).0
    }
}

extension UInt32: AdditiveArithmetic {
    @_transparent
    public static func + (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.uadd_with_overflow_Int32(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
    
    @_transparent
    public static func - (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.usub_with_overflow_Int32(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
}

extension UInt32: Comparable {
    @_transparent
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_ult_Int32(lhs._value, rhs._value))
    }
}

extension UInt32: Equatable {
    @_transparent
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_eq_Int32(lhs._value, rhs._value))
    }
}

extension UInt32: ExpressibleByIntegerLiteral {}

extension UInt32: Numeric {
    public var magnitude: Magnitude { 0 }

    @_transparent
    public static func * (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.umul_with_overflow_Int32(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
}

extension UInt32: BinaryInteger {
    @_transparent
    public static func / (lhs: UInt32, rhs: UInt32) -> UInt32 {
        precondition(rhs != (0 as UInt32), "Division by zero")
        
        let (result, overflow) = (Builtin.udiv_Int32(lhs._value, rhs._value), false._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return UInt32(result)
    }
    
    @_transparent
    public static func % (lhs: UInt32, rhs: UInt32) -> UInt32 {
        precondition(rhs != (0 as UInt32), "Division by zero in remainder operation")
        
        return UInt32(Builtin.urem_Int32(lhs._value, rhs._value))
    }
}

extension UInt32 {
    @_transparent
    public func addingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.uadd_with_overflow_Int32(_value, other._value, false._value)
        return (partialValue: UInt32(newStorage), overflow: Bool(overflow))
    }
    
    @_transparent
    public func subtractingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.usub_with_overflow_Int32(_value, other._value, false._value)
        return (partialValue: UInt32(newStorage), overflow: Bool(overflow))
    }

    @_transparent
    public func multipliedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.smul_with_overflow_Int32(_value, rhs._value, false._value)
        return (partialValue: UInt32(newStorage), overflow: Bool(overflow))
    }
    
    @_transparent
    public func dividedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
        preconditionFailure("llvm funcs")
    }
    
    @_transparent
    public func remainderReportingOverflow(dividingBy rhs: Self) -> (partialValue: Self, overflow: Bool) {
        preconditionFailure("llvm funcs")
    }
    
    @_transparent
    public func multipliedFullWidth(by other: Self) -> (high: Self, low: Self.Magnitude) {
        preconditionFailure("llvm funcs")
    }
    
    @_transparent
    public func dividingFullWidth(_ dividend: (high: Self, low: Self.Magnitude)) -> (quotient: Self, remainder: Self) {
        preconditionFailure("llvm funcs")
    }
}
