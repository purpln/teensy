public protocol _Pointer: Hashable, Strideable {
    typealias Distance = Int
    
    associatedtype Pointee
    
    var _rawValue: Builtin.RawPointer { get }
    
    init(_ _rawValue: Builtin.RawPointer)
}

extension _Pointer {
    @_transparent
    public init(_ from: OpaquePointer) {
        self.init(from._rawValue)
    }
    
    @_transparent
    public init?(_ from: OpaquePointer?) {
        guard let unwrapped = from else { return nil }
        self.init(unwrapped)
    }
    
    @_transparent
    public init?(bitPattern: Int) {
        if bitPattern == 0 { return nil }
        self.init(Builtin.inttoptr_Word(bitPattern._value))
    }
    
    @_transparent
    public init?(bitPattern: UInt) {
        if bitPattern == 0 { return nil }
        self.init(Builtin.inttoptr_Word(bitPattern._value))
    }
    
    @_transparent
    public init(@_nonEphemeral _ other: Self) {
        self.init(other._rawValue)
    }
    
    @_transparent
    public init?(@_nonEphemeral _ other: Self?) {
        guard let unwrapped = other else { return nil }
        self.init(unwrapped._rawValue)
    }
}

extension _Pointer {
    @_transparent
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_eq_RawPointer(lhs._rawValue, rhs._rawValue))
    }

    @inlinable
    @_alwaysEmitIntoClient
    public static func == <Other: _Pointer>(lhs: Self, rhs: Other) -> Bool {
        return Bool(Builtin.cmp_eq_RawPointer(lhs._rawValue, rhs._rawValue))
    }

    @inlinable
    @_alwaysEmitIntoClient
    public static func != <Other: _Pointer>(lhs: Self, rhs: Other) -> Bool {
        return Bool(Builtin.cmp_ne_RawPointer(lhs._rawValue, rhs._rawValue))
    }
}

extension _Pointer {
    @_transparent
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return Bool(Builtin.cmp_ult_RawPointer(lhs._rawValue, rhs._rawValue))
    }
    
    @inlinable
    @_alwaysEmitIntoClient
    public static func < <Other: _Pointer>(lhs: Self, rhs: Other) -> Bool {
        return Bool(Builtin.cmp_ult_RawPointer(lhs._rawValue, rhs._rawValue))
    }
    
    @inlinable
    @_alwaysEmitIntoClient
    public static func <= <Other: _Pointer>(lhs: Self, rhs: Other) -> Bool {
        return Bool(Builtin.cmp_ule_RawPointer(lhs._rawValue, rhs._rawValue))
    }
    
    @inlinable
    @_alwaysEmitIntoClient
    public static func > <Other: _Pointer>(lhs: Self, rhs: Other) -> Bool {
        return Bool(Builtin.cmp_ugt_RawPointer(lhs._rawValue, rhs._rawValue))
    }
    
    @inlinable
    @_alwaysEmitIntoClient
    public static func >= <Other: _Pointer>(lhs: Self, rhs: Other) -> Bool {
        return Bool(Builtin.cmp_uge_RawPointer(lhs._rawValue, rhs._rawValue))
    }
}

extension _Pointer {
    @_transparent
    public func successor() -> Self {
        return advanced(by: 1)
    }
    
    @_transparent
    public func predecessor() -> Self {
        return advanced(by: -1)
    }
    
    @_transparent
    public func distance(to end: Self) -> Int {
        return Int(Builtin.sub_Word(Builtin.ptrtoint_Word(end._rawValue), Builtin.ptrtoint_Word(_rawValue))) / MemoryLayout<Pointee>.stride
    }
    
    @_transparent
    public func advanced(by n: Int) -> Self {
        return Self(Builtin.gep_Word(self._rawValue, n._builtinWordValue, Pointee.self))
    }
}

extension _Pointer {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(UInt(bitPattern: self))
    }
}

extension Int {
    @_transparent
    public init<P: _Pointer>(bitPattern pointer: P?) {
        if let pointer = pointer {
            self = Int(Builtin.ptrtoint_Word(pointer._rawValue))
        } else {
            self = 0
        }
    }
}

extension UInt {
    @_transparent
    public init<P: _Pointer>(bitPattern pointer: P?) {
        if let pointer = pointer {
            self = UInt(Builtin.ptrtoint_Word(pointer._rawValue))
        } else {
            self = 0
        }
    }
}

extension Strideable where Self: _Pointer {
    @_transparent
    public static func + (@_nonEphemeral lhs: Self, rhs: Self.Stride) -> Self {
        return lhs.advanced(by: rhs)
    }
    
    @_transparent
    public static func + (lhs: Self.Stride, @_nonEphemeral rhs: Self) -> Self {
        return rhs.advanced(by: lhs)
    }
    
    @_transparent
    public static func - (@_nonEphemeral lhs: Self, rhs: Self.Stride) -> Self {
        return lhs.advanced(by: -rhs)
    }
    
    @_transparent
    public static func - (lhs: Self, rhs: Self) -> Self.Stride {
        return rhs.distance(to: lhs)
    }
    
    @_transparent
    public static func += (lhs: inout Self, rhs: Self.Stride) {
        lhs = lhs.advanced(by: rhs)
    }
    
    @_transparent
    public static func -= (lhs: inout Self, rhs: Self.Stride) {
        lhs = lhs.advanced(by: -rhs)
    }
}