@frozen
public struct Float {
    @usableFromInline
    internal var _value: Builtin.FPIEEE32

    @_transparent
    public init() {
        let zero: Int64 = 0
        self._value = Builtin.sitofp_Int64_FPIEEE32(zero._value)
    }
    
    @_transparent
    public init(_ _value: Builtin.FPIEEE32) {
        self._value = _value
    }
}


extension Float: BinaryFloatingPoint {
    public typealias Magnitude = Float
    public typealias Exponent = Int
    public typealias RawSignificand = UInt32
    public typealias RawExponent = UInt

    @inlinable
    public init(bitPattern: UInt32) {
        self.init(Builtin.bitcast_Int32_FPIEEE32(bitPattern._value))
    }

    @inlinable
    public var bitPattern: UInt32 {
        return UInt32(Builtin.bitcast_FPIEEE32_Int32(_value))
    }

    @inlinable
    @inline(__always)
    public init(_ other: Float) {
        _value = other._value
    }

    @inlinable
    @inline(__always)
    public init(_ other: Double) {
       _value = Builtin.fptrunc_FPIEEE64_FPIEEE32(other._value)
    }

    @_transparent
    public static prefix func - (operand: Self) -> Self {
        return Self(Builtin.fneg_FPIEEE32(operand._value))
    }
    
    @_transparent
    public mutating func negate() {
        _value = Builtin.fneg_FPIEEE32(_value)
    }
    
    @_transparent
    public static func + (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.fadd_FPIEEE32(lhs._value, rhs._value))
    }
    
    @_transparent
    public static func - (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.fsub_FPIEEE32(lhs._value, rhs._value))
    }
    
    @_transparent
    public static func * (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.fmul_FPIEEE32(lhs._value, rhs._value))
    }
    
    @_transparent
    public static func / (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.fdiv_FPIEEE32(lhs._value, rhs._value))
    }
    
    @_transparent
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.fcmp_oeq_FPIEEE32(lhs._value, rhs._value))
    }
    
    @_transparent
    public func rounded(_ rule: FloatingPointRoundingRule) -> Self {
        return self
    }

    @_transparent
    public func isEqual(to other: Self) -> Bool {
        return Bool(Builtin.fcmp_oeq_FPIEEE32(self._value, other._value))
    }
    
    @_transparent
    public func isLess(than other: Self) -> Bool {
        return Bool(Builtin.fcmp_olt_FPIEEE32(self._value, other._value))
    }
    
    @_transparent
    public func isLessThanOrEqualTo(_ other: Self) -> Bool {
        return Bool(Builtin.fcmp_ole_FPIEEE32(self._value, other._value))
    }
}

extension Float: _ExpressibleByBuiltinFloatLiteral {
    public init(_builtinFloatLiteral value: _MaxBuiltinFloatType) {
        _value = Builtin.fptrunc_FPIEEE64_FPIEEE32(value)
    }
}

extension Float: ExpressibleByFloatLiteral {}

extension Float: _ExpressibleByBuiltinIntegerLiteral {
    public init(_builtinIntegerLiteral value: Builtin.IntLiteral) {
        _value = Builtin.itofp_with_overflow_IntLiteral_FPIEEE32(value)
    }
}

extension Float: ExpressibleByIntegerLiteral {}

extension Float: Strideable {
    @_transparent
    public func distance(to other: Self) -> Self {
        return other - self
    }
    
    @_transparent
    public func advanced(by amount: Self) -> Self {
        return self + amount
    }
}

extension Float {
    @inlinable
    public var magnitude: Self {
        @inline(__always)
        get {
            return Float(Builtin.int_fabs_FPIEEE32(_value))
        }
    }
}