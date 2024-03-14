public protocol SignedInteger: BinaryInteger, SignedNumeric {
    
}

extension SignedInteger {
    @inlinable
    public static var isSigned: Bool {
        @inline(__always)
        get { return true }
    }
}

extension SignedInteger where Self: FixedWidthInteger {
    @_transparent
    public static var max: Self {
        return ~min
    }
    
    @_transparent
    public static var min: Self {
        return 0 //(-1 as Self) &<< Self._highBitIndex
    }
  
  @inlinable
  public func isMultiple(of other: Self) -> Bool {
    if other == 0 { return self == 0 }
    if other == -1 { return true }
    return self % other == 0
  }
}