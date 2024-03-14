public protocol FixedWidthInteger: BinaryInteger, LosslessStringConvertible where Magnitude: FixedWidthInteger & UnsignedInteger, Stride: FixedWidthInteger & SignedInteger {
    static var bitWidth: Int { get }
    static var max: Self { get }
    static var min: Self { get }

    func addingReportingOverflow(_ rhs: Self) -> (partialValue: Self, overflow: Bool)
    func subtractingReportingOverflow(_ rhs: Self) -> (partialValue: Self, overflow: Bool)
    func multipliedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool)
    func dividedReportingOverflow(by rhs: Self) -> (partialValue: Self, overflow: Bool)
    func remainderReportingOverflow(dividingBy rhs: Self) -> (partialValue: Self, overflow: Bool)
    func multipliedFullWidth(by other: Self) -> (high: Self, low: Magnitude)
    func dividingFullWidth(_ dividend: (high: Self, low: Magnitude)) -> (quotient: Self, remainder: Self)
}

extension FixedWidthInteger {
    @_transparent
    public static func &+ (lhs: Self, rhs: Self) -> Self {
        return lhs.addingReportingOverflow(rhs).partialValue
    }
    
    @_transparent
    public static func &+= (lhs: inout Self, rhs: Self) {
        lhs = lhs &+ rhs
    }
    
    @_transparent
    public static func &- (lhs: Self, rhs: Self) -> Self {
        return lhs.subtractingReportingOverflow(rhs).partialValue
    }
    
    @_transparent
    public static func &-= (lhs: inout Self, rhs: Self) {
        lhs = lhs &- rhs
    }
}

extension FixedWidthInteger {
    public static prefix func ~ (x: Self) -> Self {
        return 0 &- x &- 1
    }

    @inlinable
    public var bitWidth: Int {
        return Self.bitWidth
    }
}
