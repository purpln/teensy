@frozen
public struct Int: FixedWidthInteger, SignedInteger {
    public typealias Magnitude = UInt

    @usableFromInline
    internal var _value: Builtin.Word
    
    @_transparent
    public init(_ _value: Builtin.Word) {
        self._value = _value
    }

    @_transparent
    public static func & (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.and_Word(lhs._value, rhs._value))
    }

    @_transparent
    public static func | (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.or_Word(lhs._value, rhs._value))
    }

    @_transparent
    public static func ^ (lhs: Self, rhs: Self) -> Self {
        return Self(Builtin.xor_Word(lhs._value, rhs._value))
    }

    @_transparent
    public static var bitWidth: Int { return 64 }
}

extension Int: _ExpressibleByBuiltinIntegerLiteral {
    @_transparent
    public init(_builtinIntegerLiteral value: Builtin.IntLiteral) {
        _value = Builtin.s_to_s_checked_trunc_IntLiteral_Word(value).0
    }
}

extension Int: AdditiveArithmetic {
    @_transparent
    public static func + (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.sadd_with_overflow_Word(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
    
    @_transparent
    public static func - (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.ssub_with_overflow_Word(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
}

extension Int: Comparable {
    @_transparent
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_slt_Word(lhs._value, rhs._value))
    }
}

extension Int: Equatable {
    @_transparent
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_eq_Word(lhs._value, rhs._value))
    }
}

extension Int: ExpressibleByIntegerLiteral {}

extension Int: Numeric {
    public var magnitude: Magnitude { 0 }
    
    @_transparent
    public static func * (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = Builtin.smul_with_overflow_Word(lhs._value, rhs._value, true._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Self(result)
    }
}

extension Int: BinaryInteger {
    @_transparent
    public static func / (lhs: Int, rhs: Int) -> Int {
        precondition(rhs != (0 as Int), "Division by zero")
        
        let (result, overflow) = (Builtin.sdiv_Word(lhs._value, rhs._value), false._value)
        Builtin.condfail_message(overflow, StaticString("arithmetic overflow").unsafeRawPointer)
        return Int(result)
    }
    
    @_transparent
    public static func % (lhs: Int, rhs: Int) -> Int {
        precondition(rhs != (0 as Int), "Division by zero in remainder operation")
        
        return Int(Builtin.srem_Word(lhs._value, rhs._value))
    }
}

extension Int {
    @_transparent
    public func addingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.sadd_with_overflow_Word(_value, other._value, false._value)
        return (partialValue: Int(newStorage), overflow: Bool(overflow))
    }
    
    @_transparent
    public func subtractingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.ssub_with_overflow_Word(_value, other._value, false._value)
        return (partialValue: Int(newStorage), overflow: Bool(overflow))
    }

    @_transparent
    public func multipliedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool) {
        let (newStorage, overflow) = Builtin.smul_with_overflow_Word(_value, rhs._value, false._value)
        return (partialValue: Int(newStorage), overflow: Bool(overflow))
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

extension Int {
    @_transparent
    public static func &>> (lhs: Self, rhs: Self) -> Self {
        return Int(Builtin.lshr_Word(lhs._value, rhs._value))
    }

    @_transparent
    public static func &<< (lhs: Self, rhs: Self) -> Self {
        return Int(Builtin.shl_Word(lhs._value, rhs._value))
    }
}
/*
extension Int {
    @frozen
    public struct Words: RandomAccessCollection, Sendable {
        public typealias Indices = Range<Int>
        public typealias SubSequence = Slice<Int.Words>

    @usableFromInline
    internal var _value: Int

    @inlinable
    public init(_ value: Int) {
      self._value = value
    }

    @inlinable
    public var count: Int {
      return (${bits} + ${word_bits} - 1) / ${word_bits}
    }

    @inlinable
    public var startIndex: Int { return 0 }

    @inlinable
    public var endIndex: Int { return count }

    @inlinable
    public var indices: Indices { return startIndex ..< endIndex }

    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* ${word_bits}
        _internalInvariant(shift < UInt(_value.bitWidth._value))
        return (_value &>> ${Self}(_truncatingBits: shift))._lowWord
      }
    }
  }
}
*/
