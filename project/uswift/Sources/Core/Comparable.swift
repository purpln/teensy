public protocol Comparable: Equatable {
  static func < (_ lhs: Self, _ rhs: Self) -> Bool
  static func <= (_ lhs: Self, _ rhs: Self) -> Bool
  static func >= (_ lhs: Self, _ rhs: Self) -> Bool
  static func > (_ lhs: Self, _ rhs: Self) -> Bool
}

extension Comparable {
  @inlinable
  public static func > (_ lhs: Self, _ rhs: Self) -> Bool {
    return rhs < lhs
  }

  @inlinable
  public static func <= (_ lhs: Self, _ rhs: Self) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable
  public static func >= (_ lhs: Self, _ rhs: Self) -> Bool {
    return !(lhs < rhs)
  }
}
