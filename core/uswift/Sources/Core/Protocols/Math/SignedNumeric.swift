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