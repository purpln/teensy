public protocol Numeric: AdditiveArithmetic, ExpressibleByIntegerLiteral {
    associatedtype Magnitude: Comparable, Numeric
    /*
    init?<T: BinaryInteger>(exactly source: T)
    */
    var magnitude: Magnitude { get }

    static func * (lhs: Self, rhs: Self) -> Self
    static func *= (lhs: inout Self, rhs: Self)
}

public extension Numeric {
    @_alwaysEmitIntoClient
    static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
}
