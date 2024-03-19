public protocol SignedNumeric: Numeric {
    static prefix func - (operand: Self) -> Self
    
    mutating func negate()
}

extension SignedNumeric {
    @_transparent
    public static prefix func - (operand: Self) -> Self {
        var result = operand
        result.negate()
        return result
    }
    
    @_transparent
    public mutating func negate() {
        self = 0 - self
    }
}

/*
@inlinable
public func abs<T: SignedNumeric & Comparable>(_ x: T) -> T {
    if T.self == T.Magnitude.self {
        return unsafeBitCast(x.magnitude, to: T.self)
    }
    return x < (0 as T) ? -x : x
}
*/
