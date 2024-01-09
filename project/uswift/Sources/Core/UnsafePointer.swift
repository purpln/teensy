@frozen
public struct UnsafePointer<Pointee>: _Pointer {
  public let _rawValue: Builtin.RawPointer

  @_transparent
  public init(_ _rawValue: Builtin.RawPointer) {
    self._rawValue = _rawValue
  }

  @inlinable
  public var pointee: Pointee {
    @_transparent unsafeAddress {
      return self
    }
  }
}
