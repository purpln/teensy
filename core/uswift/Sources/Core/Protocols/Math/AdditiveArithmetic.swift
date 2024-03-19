public protocol AdditiveArithmetic: Equatable {
    static var zero: Self { get }
    
    static func + (lhs: Self, rhs: Self) -> Self
    static func += (lhs: inout Self, rhs: Self)
    static func - (lhs: Self, rhs: Self) -> Self
    static func -= (lhs: inout Self, rhs: Self)
}

public extension AdditiveArithmetic {
    @_alwaysEmitIntoClient
    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
    
    @_alwaysEmitIntoClient
    static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    @_transparent
    static prefix func + (x: Self) -> Self {
        return x
    }
}

public extension AdditiveArithmetic where Self: ExpressibleByIntegerLiteral {
    @inlinable @inline(__always)
    static var zero: Self {
        return 0
    }
}