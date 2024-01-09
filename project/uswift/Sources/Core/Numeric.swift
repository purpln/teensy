public protocol Numeric: AdditiveArithmetic, ExpressibleByIntegerLiteral {
  static func * (_ lhs: Self, _ rhs: Self) -> Self
  static func *= (_ lhs: inout Self, _ rhs: Self)
}

public extension Numeric {
  @_alwaysEmitIntoClient
  static func *= (_ lhs: inout Self, _ rhs: Self) {
    lhs = lhs * rhs
  }
}
