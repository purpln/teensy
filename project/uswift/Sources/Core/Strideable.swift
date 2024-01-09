public protocol Strideable: Comparable {
  associatedtype Stride: SignedNumeric, Comparable

  func distance(to other: Self) -> Stride
  func advanced(by n: Stride) -> Self

  static func _step(after current: (index: Int?, value: Self),
                    from start: Self, by distance: Self.Stride)
      -> (index: Int?, value: Self)
}

public extension Strideable {
  @inlinable
  static func _step(after current: (index: Int?, value: Self),
                    from _: Self, by distance: Self.Stride)
      -> (index: Int?, value: Self) {
    return (nil, current.value.advanced(by: distance))
  }
}
