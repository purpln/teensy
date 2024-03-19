public typealias CBool = Bool
public typealias CChar = Int8
public typealias CInt = Int32
public typealias CLong = Int
public typealias CFloat = Float
public typealias CDouble = Double

@frozen
public struct OpaquePointer {
    @usableFromInline
    internal var _rawValue: Builtin.RawPointer
    
    @usableFromInline @_transparent
    internal init(_ v: Builtin.RawPointer) {
        _rawValue = v
    }
    
    @_transparent
    public init?(bitPattern: Int) {
        if bitPattern == 0 { return nil }
        _rawValue = Builtin.inttoptr_Word(bitPattern._value)
    }
    
    @_transparent
    public init?(bitPattern: UInt) {
        if bitPattern == 0 { return nil }
        _rawValue = Builtin.inttoptr_Word(bitPattern._value)
    }
    
    @_transparent
    public init<T>(@_nonEphemeral _ from: UnsafePointer<T>) {
        _rawValue = from._rawValue
    }
    
    @_transparent
    public init?<T>(@_nonEphemeral _ from: UnsafePointer<T>?) {
        guard let unwrapped = from else { return nil }
        self.init(unwrapped)
    }
    
    @_transparent
    public init<T>(@_nonEphemeral _ from: UnsafeMutablePointer<T>) {
        _rawValue = from._rawValue
    }
    
    @_transparent
    public init?<T>(@_nonEphemeral _ from: UnsafeMutablePointer<T>?) {
        guard let unwrapped = from else { return nil }
        self.init(unwrapped)
    }
}

extension OpaquePointer: Equatable {
    @inlinable
    public static func == (lhs: OpaquePointer, rhs: OpaquePointer) -> Bool {
        return Bool(Builtin.cmp_eq_RawPointer(lhs._rawValue, rhs._rawValue))
    }
}

extension OpaquePointer: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Int(Builtin.ptrtoint_Word(_rawValue)))
    }
}
/*
extension Int {
    @inlinable
    public init(bitPattern pointer: OpaquePointer?) {
        self.init(bitPattern: UnsafeRawPointer(pointer))
    }
}

extension UInt {
    @inlinable
    public init(bitPattern pointer: OpaquePointer?) {
        self.init(bitPattern: UnsafeRawPointer(pointer))
    }
}
*/