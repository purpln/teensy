@inlinable
public func withUnsafeMutablePointer<T, Result>(to value: inout T,
                                                _ body: (UnsafeMutablePointer<T>) throws -> Result)
    rethrows -> Result {
  return try body(UnsafeMutablePointer<T>(Builtin.addressof(&value)))
}
