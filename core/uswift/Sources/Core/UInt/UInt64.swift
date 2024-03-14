@frozen
public struct UInt64: FixedWidthInteger, UnsignedInteger {
    public typealias Magnitude = UInt64
    
    @usableFromInline
    internal var _value: Builtin.Int64
    
    @_transparent
    public init(_ _value: Builtin.Int64) {
        self._value = _value
    }
    
    @_transparent
    public static func & (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.and_Int64(lhs._value, rhs._value))
    }

    @_transparent
    public static func | (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.or_Int64(lhs._value, rhs._value))
    }

    @_transparent
    public static func ^ (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.xor_Int64(lhs._value, rhs._value))
    }

    @_transparent
    public static var bitWidth: Int { return 64 }
}

extension UInt64: _ExpressibleByBuiltinIntegerLiteral {
    @_transparent
    public init(_builtinIntegerLiteral value: Builtin.IntLiteral) {
        _value = Builtin.s_to_s_checked_trunc_IntLiteral_Int64(value).0
    }
}

extension UInt64: AdditiveArithmetic {
    @_transparent
    public static func + (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.sadd_with_overflow_Int64(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
    
    @_transparent
    public static func - (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.ssub_with_overflow_Int64(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
}

extension UInt64: Comparable {
    @_transparent
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_slt_Int64(lhs._value, rhs._value))
    }
}

extension UInt64: Equatable {
    @_transparent
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
    }
}

extension UInt64: ExpressibleByIntegerLiteral {}

extension UInt64: Numeric {
    public var magnitude: Magnitude { 0 }

    @_transparent
    public static func * (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.smul_with_overflow_Int64(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
}

extension UInt64: BinaryInteger {
    @_transparent
    public static func / (lhs: UInt64, rhs: UInt64) -> UInt64 {
        precondition(rhs != (0 as UInt64), "Division by zero")
        
        let (result, overflow) = (Builtin.udiv_Int64(lhs._value, rhs._value), false._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return UInt64(result)
    }
    
    @_transparent
    public static func % (lhs: UInt64, rhs: UInt64) -> UInt64 {
        precondition(rhs != (0 as UInt64), "Division by zero in remainder operation")
        
        return UInt64(Builtin.urem_Int64(lhs._value, rhs._value))
    }
}

extension UInt64 {
    @_transparent
    public func addingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.uadd_with_overflow_Int64(_value, other._value, false._value)
        return (partialValue: UInt64(newStorage), overflow: Bool(overflow))
    }
    
    @_transparent
    public func subtractingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.usub_with_overflow_Int64(_value, other._value, false._value)
        return (partialValue: UInt64(newStorage), overflow: Bool(overflow))
    }

    @_transparent
    public func multipliedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.smul_with_overflow_Int64(_value, rhs._value, false._value)
        return (partialValue: UInt64(newStorage), overflow: Bool(overflow))
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
