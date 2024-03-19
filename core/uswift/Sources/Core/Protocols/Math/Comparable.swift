public protocol Comparable: Equatable {
    static func < (lhs: Self, rhs: Self) -> Bool
    static func > (lhs: Self, rhs: Self) -> Bool
    static func <= (lhs: Self, rhs: Self) -> Bool
    static func >= (lhs: Self, rhs: Self) -> Bool
}

extension Comparable {
    @inlinable
    public static func > (lhs: Self, rhs: Self) -> Bool {
        return rhs < lhs
    }
    
    @inlinable
    public static func <= (lhs: Self, rhs: Self) -> Bool {
        return !(rhs < lhs)
    }
    
    @inlinable
    public static func >= (lhs: Self, rhs: Self) -> Bool {
        return !(lhs < rhs)
    }
}

extension Comparable {
    @_transparent
    public static func ... (minimum: Self, maximum: Self) -> ClosedRange<Self> {
        precondition(minimum <= maximum, "Range requires lowerBound <= upperBound")
        return ClosedRange(_uncheckedBounds: (lower: minimum, upper: maximum))
    }
}

extension Comparable {
    public static func ..< (minimum: Self, maximum: Self) -> Range<Self> {
        precondition(minimum <= maximum, "Range requires lowerBound <= upperBound")
        return Range(_uncheckedBounds: (lower: minimum, upper: maximum))
    }
}
