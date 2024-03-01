public protocol FixedWidthInteger: BinaryInteger {
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
    
    /*
    init(_truncatingBits bits: UInt)
    init(bigEndian value: Self)
    init(littleEndian value: Self)
    var bigEndian: Self { get }
    var littleEndian: Self { get }
    */

    /*
    static func &>> (lhs: Self, rhs: Self) -> Self
    static func &>>= (lhs: inout Self, rhs: Self)
    static func &<< (lhs: Self, rhs: Self) -> Self
    static func &<<= (lhs: inout Self, rhs: Self)
    */
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

/*
extension FixedWidthInteger {
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent
    public static func &>>= (lhs: inout Self, rhs: Self) -> Self {
        lhs = lhs &>> rhs
    }

    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent
    public static func &>> <Other: BinaryInteger>(lhs: Self, rhs: Other) -> Self {
        return lhs &>> Self(truncatingIfNeeded: rhs)
    }

    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent
    public static func &>>= <Other: BinaryInteger>(lhs: inout Self, rhs: Other) {
        lhs = lhs &>> rhs
    }
}
*/