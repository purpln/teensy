public protocol SignedNumeric: Numeric {
    static prefix func - (operand: Self) -> Self
    
    mutating func negate()
}

extension SignedNumeric {
    @_transparent
    public static prefix func - (operand: Self) -> Self {
        0 - self
    }

    @_transparent
    public mutating func negate() {
        self = -self
    }
}