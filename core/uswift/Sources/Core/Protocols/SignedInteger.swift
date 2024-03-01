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
    // Nothing but zero is a multiple of zero.
    if other == 0 { return self == 0 }
    // Special case to avoid overflow on .min / -1 for signed types.
    if other == -1 { return true }
    // Having handled those special cases, this is safe.
    return self % other == 0
  }
}