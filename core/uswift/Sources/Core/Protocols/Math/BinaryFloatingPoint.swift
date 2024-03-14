public protocol BinaryFloatingPoint: FloatingPoint, ExpressibleByFloatLiteral {
    associatedtype RawSignificand: UnsignedInteger
    associatedtype RawExponent: UnsignedInteger
    /*
    init(sign: FloatingPointSign, exponentBitPattern: RawExponent, significandBitPattern: RawSignificand)
    */
    init(_ value: Float)
    init(_ value: Double)
    /*
    init<Source: BinaryFloatingPoint>(_ value: Source)
    init?<Source: BinaryFloatingPoint>(exactly value: Source)
    */
}

/*
extension BinaryFloatingPoint {
    @inlinable @inline(__always)
    public static var radix: Int { return 2 }
}
*/