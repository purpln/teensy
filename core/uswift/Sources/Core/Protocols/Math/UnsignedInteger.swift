public protocol UnsignedInteger: BinaryInteger {
    
}

extension UnsignedInteger {
    @inlinable
    public var magnitude: Self {
        @inline(__always)
        get { return self }
    }

    @inlinable
    public static var isSigned: Bool {
        @inline(__always)
        get { return false }
    }
}

extension UnsignedInteger where Self: FixedWidthInteger {
    @_transparent
    public static var max: Self {return ~0 }
    
    @_transparent
    public static var min: Self { return 0 }
}