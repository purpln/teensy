@frozen
public struct UnsafePointer<Pointee>: _Pointer {
    public let _rawValue: Builtin.RawPointer
    
    @_transparent
    public init(_ _rawValue: Builtin.RawPointer) {
        self._rawValue = _rawValue
    }

    @inlinable
    public func deallocate() {
        Builtin.deallocRaw(_rawValue, (-1)._value, (0)._value)
    }
    
    @inlinable
    public var pointee: Pointee {
        @_transparent unsafeAddress {
            return self
        }
    }

    @inlinable
    public subscript(i: Int) -> Pointee {
        @_transparent
        unsafeAddress {
            return self + i
        }
    }
}
