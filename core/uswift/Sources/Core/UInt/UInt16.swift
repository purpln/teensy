@frozen
public struct UInt16: FixedWidthInteger, UnsignedInteger {
    public typealias Magnitude = UInt16
    
    @usableFromInline
    internal var _value: Builtin.Int16
    
    @_transparent
    public init(_ _value: Builtin.Int16) {
        self._value = _value
    }
    
    @_transparent
    public static func & (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.and_Int16(lhs._value, rhs._value))
    }

    @_transparent
    public static func | (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.or_Int16(lhs._value, rhs._value))
    }

    @_transparent
    public static func ^ (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.xor_Int16(lhs._value, rhs._value))
    }

    @_transparent
    public static var bitWidth: Int { return 16 }
}

extension UInt16: _ExpressibleByBuiltinIntegerLiteral {
    @_transparent
    public init(_builtinIntegerLiteral value: Builtin.IntLiteral) {
        _value = Builtin.s_to_s_checked_trunc_IntLiteral_Int16(value).0
    }
}

extension UInt16: AdditiveArithmetic {
    @_transparent
    public static func + (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.sadd_with_overflow_Int16(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
    
    @_transparent
    public static func - (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.ssub_with_overflow_Int16(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
}

extension UInt16: Comparable {
    @_transparent
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_slt_Int16(lhs._value, rhs._value))
    }
}

extension UInt16: Equatable {
    @_transparent
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_eq_Int16(lhs._value, rhs._value))
    }
}

extension UInt16: ExpressibleByIntegerLiteral {}

extension UInt16: Numeric {
    public var magnitude: Magnitude { 0 }

    @_transparent
    public static func * (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.smul_with_overflow_Int16(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
}

extension UInt16: BinaryInteger {
    @_transparent
    public static func / (lhs: UInt16, rhs: UInt16) -> UInt16 {
        precondition(rhs != (0 as UInt16), "Division by zero")
        
        let (result, overflow) = (Builtin.udiv_Int16(lhs._value, rhs._value), false._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return UInt16(result)
    }
    
    @_transparent
    public static func % (lhs: UInt16, rhs: UInt16) -> UInt16 {
        precondition(rhs != (0 as UInt16), "Division by zero in remainder operation")
        
        return UInt16(Builtin.urem_Int16(lhs._value, rhs._value))
    }
}

extension UInt16 {
    @_transparent
    public func addingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.uadd_with_overflow_Int16(_value, other._value, false._value)
        return (partialValue: UInt16(newStorage), overflow: Bool(overflow))
    }
    
    @_transparent
    public func subtractingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.usub_with_overflow_Int16(_value, other._value, false._value)
        return (partialValue: UInt16(newStorage), overflow: Bool(overflow))
    }

    @_transparent
    public func multipliedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.smul_with_overflow_Int16(_value, rhs._value, false._value)
        return (partialValue: UInt16(newStorage), overflow: Bool(overflow))
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
