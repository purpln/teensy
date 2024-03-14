public protocol BinaryInteger: CustomStringConvertible, Hashable, Numeric, Strideable where Magnitude: BinaryInteger, Magnitude.Magnitude == Magnitude {
    static var isSigned: Bool { get }
    
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
        preconditionFailure("wip")
        //return (self > (0 as Self) ? 1 : 0) - (self < (0 as Self) ? 1 : 0)
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

extension BinaryInteger {
    @inlinable
    @inline(__always)
    public func distance(to other: Self) -> Int {
        /*
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
        */
        preconditionFailure("wip")
    }
    
    @inlinable
    @inline(__always)
    public func advanced(by n: Int) -> Self {
        /*
        if Self.isSigned {
            return self.bitWidth < n.bitWidth
            ? Self(Int(truncatingIfNeeded: self) + n)
            : self + Self(truncatingIfNeeded: n)
        } else {
            return n < (0 as Int)
            ? self - Self(UInt(bitPattern: ~n &+ 1))
            : self + Self(UInt(bitPattern: n))
        }
        */
        preconditionFailure("wip")
    }
}
