@frozen
public struct UnsafeMutablePointer<Pointee>: _Pointer {
    public let _rawValue: Builtin.RawPointer
    
    @_transparent
    public init(_ _rawValue: Builtin.RawPointer) {
        self._rawValue = _rawValue
    }

    @_transparent
    public init(@_nonEphemeral mutating other: UnsafePointer<Pointee>) {
        self._rawValue = other._rawValue
    }
    
    @_transparent
    public init?(@_nonEphemeral mutating other: UnsafePointer<Pointee>?) {
        guard let unwrapped = other else { return nil }
        self.init(mutating: unwrapped)
    }

    @_transparent
    public init(@_nonEphemeral _ other: UnsafeMutablePointer<Pointee>) {
        self._rawValue = other._rawValue
    }
    
    @_transparent
    public init?(@_nonEphemeral _ other: UnsafeMutablePointer<Pointee>?) {
        guard let unwrapped = other else { return nil }
        self.init(unwrapped)
    }

    @inlinable
    public static func allocate(byteCount: Int, alignment: Int) -> UnsafeMutableRawPointer {
        let alignment: Int = alignment <= minAllocationAlignment() ? 0 : alignment
        return UnsafeMutableRawPointer(Builtin.allocRaw(byteCount._value, alignment._value))
    }

    @inlinable
    public static func allocate(capacity count: Int) -> UnsafeMutablePointer<Pointee> {
        let size = MemoryLayout<Pointee>.stride * count
        let align = Int(Builtin.alignof(Pointee.self))
        let alignment: Int = align <= minAllocationAlignment() ? 0 : align

        let rawPtr = Builtin.allocRaw(size._value, alignment._value)
        Builtin.bindMemory(rawPtr, count._value, Pointee.self)
        return UnsafeMutablePointer(rawPtr)
    }

    @inlinable
    public func deallocate() {
        Builtin.deallocRaw(_rawValue, (-1)._value, (0)._value)
    }

    @inlinable
    public var pointee: Pointee {
        @_transparent unsafeAddress {
            return UnsafePointer(self)
        }
        @_transparent nonmutating unsafeMutableAddress {
            return self
        }
    }
}

@inlinable
public func withUnsafeMutablePointer<T, Result>(to value: inout T, _ body: (UnsafeMutablePointer<T>) throws -> Result) rethrows -> Result {
    return try body(UnsafeMutablePointer<T>(Builtin.addressof(&value)))
}
