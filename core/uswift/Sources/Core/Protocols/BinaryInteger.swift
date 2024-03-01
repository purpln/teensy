public protocol BinaryInteger: CustomStringConvertible, Hashable, Numeric, Strideable where Magnitude: BinaryInteger, Magnitude.Magnitude == Magnitude {
    static var isSigned: Bool { get }
    
    /*
    init?<T: BinaryFloatingPoint>(exactly source: T)
    init<T: BinaryFloatingPoint>(_ source: T)
    init<T: BinaryInteger>(_ source: T)
    init<T: BinaryInteger>(truncatingIfNeeded source: T)
    init<T: BinaryInteger>(clamping source: T)
    associatedtype Words: RandomAccessCollection where Words.Element == UInt, Words.Index == Int
    var words: Words { get }
    var trailingZeroBitCount: Int { get }
    */
    var bitWidth: Int { get }

    static prefix func ~ (x: Self) -> Self

    static func / (lhs: Self, rhs: Self) -> Self
    static func % (lhs: Self, rhs: Self) -> Self

    static func & (lhs: Self, rhs: Self) -> Self
    static func | (lhs: Self, rhs: Self) -> Self

    static func ^ (lhs: Self, rhs: Self) -> Self

    static func /= (lhs: inout Self, rhs: Self)
    static func %= (lhs: inout Self, rhs: Self)

    static func &= (lhs: inout Self, rhs: Self)
    static func |= (lhs: inout Self, rhs: Self)

    static func ^= (lhs: inout Self, rhs: Self)

    override static func + (lhs: Self, rhs: Self) -> Self
    override static func - (lhs: Self, rhs: Self) -> Self
    override static func * (lhs: Self, rhs: Self) -> Self
    
    override static func += (lhs: inout Self, rhs: Self)
    override static func -= (lhs: inout Self, rhs: Self)
    override static func *= (lhs: inout Self, rhs: Self)
    /*
    static func >> <RHS: BinaryInteger>(lhs: Self, rhs: RHS) -> Self
    static func >>= <RHS: BinaryInteger>(lhs: inout Self, rhs: RHS)
    static func << <RHS: BinaryInteger>(lhs: Self, rhs: RHS) -> Self
    static func <<= <RHS: BinaryInteger>(lhs: inout Self, rhs: RHS)
    */
    func quotientAndRemainder(dividingBy rhs: Self) -> (quotient: Self, remainder: Self)
    func isMultiple(of other: Self) -> Bool
    func signum() -> Self
}

extension BinaryInteger {
    @_transparent
    public init() {
        self = 0
    }

    @inlinable
    public func quotientAndRemainder(dividingBy rhs: Self) -> (quotient: Self, remainder: Self) {
        return (self / rhs, self % rhs)
    }

    @inlinable
    public func isMultiple(of other: Self) -> Bool {
        if other == 0 { return self == 0 }
        return self.magnitude % other.magnitude == 0
    }

    @inlinable
    public func signum() -> Self {
        return (self > (0 as Self) ? 1 : 0) - (self < (0 as Self) ? 1 : 0)
    }
}

extension BinaryInteger {
    @_transparent
    public static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }
    
    @_transparent
    public static func %= (lhs: inout Self, rhs: Self) {
        lhs = lhs % rhs
    }

    @_transparent
    public static func &= (lhs: inout Self, rhs: Self) {
        lhs = lhs & rhs
    }

    @_transparent
    public static func |= (lhs: inout Self, rhs: Self) {
        lhs = lhs | rhs
    }

    @_transparent
    public static func ^= (lhs: inout Self, rhs: Self) {
        lhs = lhs ^ rhs
    }
}

extension BinaryInteger {
    @_transparent
    public var magnitude: Magnitude {
        let base = Magnitude(_value)
        return self < (0 as ${Self}) ? ~base &+ 1 : base
    }
}
/*
extension BinaryInteger {
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent
    public static func >>= <RHS: BinaryInteger>(lhs: inout Self, rhs: RHS) -> Self {
        lhs = lhs >> rhs
    }

    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent
    public static func <<= <RHS: BinaryInteger>(lhs: inout Self, rhs: RHS) -> Self {
        lhs = lhs << rhs
    }
}
*/
extension BinaryInteger {
    @inlinable
    @inline(__always)
    public func distance(to other: Self) -> Int {
        if !Self.isSigned {
            if self > other {
                if let result = Int(exactly: self - other) {
                    return -result
                }
            } else {
                if let result = Int(exactly: other - self) {
                    return result
                }
            }
        } else {
            let isNegative = self < (0 as Self)
            if isNegative == (other < (0 as Self)) {
                if let result = Int(exactly: other - self) {
                    return result
                }
            } else {
                if let result = Int(exactly: self.magnitude + other.magnitude) {
                    return isNegative ? result : -result
                }
            }
        }
        preconditionFailure("Distance is not representable in Int")
    }
    
    @inlinable
    @inline(__always)
    public func advanced(by n: Int) -> Self {
        if Self.isSigned {
            return self.bitWidth < n.bitWidth ? Self(Int(truncatingIfNeeded: self) + n) : self + Self(truncatingIfNeeded: n)
        } else {
            return n < (0 as Int) ? self - Self(UInt(bitPattern: ~n &+ 1)) : self + Self(UInt(bitPattern: n))
        }
  }
}

extension BinaryInteger {
     @_transparent
     public static func == <Other: BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
        if Self.isSigned == Other.isSigned {
            return lhs.bitWidth >= rhs.bitWidth ? lhs == Self(truncatingIfNeeded: rhs) : Other(truncatingIfNeeded: lhs) == rhs
        }
        if Self.isSigned {
            return lhs.bitWidth > rhs.bitWidth ? lhs == Self(truncatingIfNeeded: rhs) : (lhs >= (0 as Self) && Other(truncatingIfNeeded: lhs) == rhs)
        }
        return lhs.bitWidth < rhs.bitWidth ? Other(truncatingIfNeeded: lhs) == rhs : (rhs >= (0 as Other) && lhs == Self(truncatingIfNeeded: rhs))
    }
    
    @_transparent
    public static func != <Other: BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
        return !(lhs == rhs)
    }
    
    @_transparent
    public static func < <Other: BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
        if Self.isSigned == Other.isSigned {
            return lhs.bitWidth >= rhs.bitWidth ? lhs < Self(truncatingIfNeeded: rhs) : Other(truncatingIfNeeded: lhs) < rhs
        }
        if Self.isSigned {
            return lhs.bitWidth > rhs.bitWidth ? lhs < Self(truncatingIfNeeded: rhs) : (lhs < (0 as Self) || Other(truncatingIfNeeded: lhs) < rhs)
        }
        return lhs.bitWidth < rhs.bitWidth ? Other(truncatingIfNeeded: lhs) < rhs : (rhs > (0 as Other) && lhs < Self(truncatingIfNeeded: rhs))
    }

    @_transparent
    public static func > <Other: BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
        return rhs < lhs
    }
    
    @_transparent
    public static func <= <Other: BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
        return !(rhs < lhs)
    }
    
    @_transparent
    public static func >= <Other: BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
        return !(lhs < rhs)
    }
}

extension BinaryInteger {
    @_transparent
    public static func != (lhs: Self, rhs: Self) -> Bool {
        return !(lhs == rhs)
    }
    
    @_transparent
    public static func <= (lhs: Self, rhs: Self) -> Bool {
        return !(rhs < lhs)
    }
    
    @_transparent
    public static func >= (lhs: Self, rhs: Self) -> Bool {
        return !(lhs < rhs)
    }
    
    @_transparent
    public static func > (lhs: Self, rhs: Self) -> Bool {
        return rhs < lhs
    }
}