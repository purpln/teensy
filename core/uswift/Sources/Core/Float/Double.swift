@frozen
public struct Double {
    @usableFromInline
    internal var _value: Builtin.FPIEEE64

    @_transparent
    public init() {
        //missing __aeabi_l2d & __aeabi_ldivmod
        let zero: Int32 = 0
        let float = Builtin.sitofp_Int32_FPIEEE32(zero._value)
        self._value = Builtin.fpext_FPIEEE32_FPIEEE64(float)
        //let zero: Int64 = 0
        //self._value = Builtin.sitofp_Int64_FPIEEE64(zero._value)
    }
    
    @_transparent
    public init(_ _value: Builtin.FPIEEE64) {
        self._value = _value
    }
}

extension Double: BinaryFloatingPoint {
    public typealias Magnitude = Double
    public typealias Exponent = Int
    public typealias RawSignificand = UInt64
    public typealias RawExponent = UInt

    @inlinable
    public init(bitPattern: UInt64) {
        self.init(Builtin.bitcast_Int64_FPIEEE64(bitPattern._value))
    }

    @inlinable
    public var bitPattern: UInt64 {
        return UInt64(Builtin.bitcast_FPIEEE64_Int64(_value))
    }

    @inlinable
    @inline(__always)
    public init(_ other: Float) {
        _value = Builtin.fpext_FPIEEE32_FPIEEE64(other._value)
    }

    @inlinable
    @inline(__always)
    public init(_ other: Double) {
        _value = other._value
    }

    @_transparent
    public static prefix func - (operand: Self) -> Self {
        return Self(Builtin.fneg_FPIEEE64(operand._value))
    }
    
    @_transparent
    public mutating func negate() {
        _value = Builtin.fneg_FPIEEE64(_value)
    }
    
    @_transparent
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.fadd_FPIEEE64(lhs._value, rhs._value))
    }
    
    @_transparent
    public static func - (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.fsub_FPIEEE64(lhs._value, rhs._value))
    }
    
    @_transparent
    public static func * (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.fmul_FPIEEE64(lhs._value, rhs._value))
    }
    
    @_transparent
    public static func / (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.fdiv_FPIEEE64(lhs._value, rhs._value))
    }
    
    @_transparent
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.fcmp_oeq_FPIEEE64(lhs._value, rhs._value))
    }
    
    @_transparent
    public func rounded(_ rule: FloatingPointRoundingRule) -> Self {
        preconditionFailure("wip")
    }

    @_transparent
    public func isEqual(to other: Self) -> Bool {
        return Bool(Builtin.fcmp_oeq_FPIEEE64(self._value, other._value))
    }
    
    @_transparent
    public func isLess(than other: Self) -> Bool {
        return Bool(Builtin.fcmp_olt_FPIEEE64(self._value, other._value))
    }
    
    @_transparent
    public func isLessThanOrEqualTo(_ other: Self) -> Bool {
        return Bool(Builtin.fcmp_ole_FPIEEE64(self._value, other._value))
    }
}

extension Double: _ExpressibleByBuiltinFloatLiteral {
    public init(_builtinFloatLiteral value: MaxBuiltinFloatType) {
        _value = value
    }
}

extension Double: ExpressibleByFloatLiteral {}

extension Double: _ExpressibleByBuiltinIntegerLiteral {
    public init(_builtinIntegerLiteral value: Builtin.IntLiteral) {
        _value = Builtin.itofp_with_overflow_IntLiteral_FPIEEE64(value)
    }
}

extension Double: ExpressibleByIntegerLiteral {}

extension Double: Strideable {
    @_transparent
    public func distance(to other: Self) -> Self {
        return other - self
    }
    
    @_transparent
    public func advanced(by amount: Self) -> Self {
        return self + amount
    }
}

extension Double {
    @inlinable
    public var magnitude: Self {
        @inline(__always)
        get {
            return Double(Builtin.int_fabs_FPIEEE64(_value))
        }
    }
}
