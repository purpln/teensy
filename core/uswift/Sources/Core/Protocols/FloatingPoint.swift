public protocol FloatingPoint: SignedNumeric, Strideable, Hashable where Magnitude == Self {
    associatedtype Exponent: SignedInteger
    /*
    init(sign: FloatingPointSign, exponent: Exponent, significand: Self)
    init(_ value: Int)
    init<Source: BinaryInteger>(_ value: Source)
    init?<Source: BinaryInteger>(exactly value: Source)

    static var radix: Int { get }
    static var nan: Self { get }
    static var signalingNaN: Self { get }
    static var infinity: Self { get }
    static var pi: Self { get }
    static var greatestFiniteMagnitude: Self { get }
    static var leastNormalMagnitude: Self { get }
    static var leastNonzeroMagnitude: Self { get }
    var sign: FloatingPointSign { get }
    var exponent: Exponent { get }
    var significand: Self { get }
    */

    override static func + (lhs: Self, rhs: Self) -> Self
    override static func += (lhs: inout Self, rhs: Self)

    override static func -(lhs: Self, rhs: Self) -> Self
    override static func -=(lhs: inout Self, rhs: Self)
    
    override static prefix func - (_ operand: Self) -> Self
    override mutating func negate()

    override static func * (lhs: Self, rhs: Self) -> Self
    override static func *= (lhs: inout Self, rhs: Self)
    static func / (lhs: Self, rhs: Self) -> Self
    static func /= (lhs: inout Self, rhs: Self)

    func rounded(_ rule: FloatingPointRoundingRule) -> Self
    mutating func round(_ rule: FloatingPointRoundingRule)

    func isEqual(to other: Self) -> Bool
    func isLess(than other: Self) -> Bool
    func isLessThanOrEqualTo(_ other: Self) -> Bool
}

extension FloatingPoint {
    @_transparent
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
    @_transparent
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.isLess(than: rhs)
    }
    
    @_transparent
    public static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.isLessThanOrEqualTo(rhs)
    }
    
    @_transparent
    public static func > (lhs: Self, rhs: Self) -> Bool {
        return rhs.isLess(than: lhs)
    }
    
    @_transparent
    public static func >= (lhs: Self, rhs: Self) -> Bool {
        return rhs.isLessThanOrEqualTo(lhs)
    }
}

extension FloatingPoint {
    @_transparent
    public static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }
}

extension FloatingPoint {
    @_transparent
    public func rounded() -> Self {
        return rounded(.toNearestOrAwayFromZero)
    }
    
    @_transparent
    public mutating func round() {
        round(.toNearestOrAwayFromZero)
    }

    @_transparent
    public mutating func round(_ rule: FloatingPointRoundingRule) {
        self = rounded(.toNearestOrAwayFromZero)
    }
}