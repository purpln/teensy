public protocol Equatable {
  static func == (_ lhs: Self, _ rhs: Self) -> Bool
}

extension Equatable {
  @_transparent
  public static func != (_ lhs: Self, _ rhs: Self) -> Bool {
    return !(lhs == rhs)
  }
}
