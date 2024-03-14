@frozen
public enum Optional<Wrapped>: ExpressibleByNilLiteral {
    case none
    case some(Wrapped)
    
    @_transparent
    public init(_ value: Wrapped) {
        self = .some(value)
    }
    
    @_transparent
    public init(nilLiteral: ()) {
        self = .none
    }
}

extension Optional: Equatable where Wrapped: Equatable {
    @inlinable
    public static func == (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        switch (lhs, rhs) {
        case let (l?, r?):
            return l == r
        case (nil, nil):
            return true
        default:
            return false
        }
    }
    
    @inlinable
    public static func != (lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        return !(lhs == rhs)
    }
}
/*
extension Optional: Hashable where Wrapped: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .none:
            hasher.combine(0 as UInt8)
        case .some(let wrapped):
            hasher.combine(1 as UInt8)
            hasher.combine(wrapped)
        }
    }
}
*/
extension Optional {
    @inlinable
    public func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U? {
        switch self {
        case .some(let y):
            return .some(try transform(y))
        case .none:
            return .none
        }
    }

    @inlinable
    public func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U? {
        switch self {
        case .some(let y):
            return try transform(y)
        case .none:
            return .none
        }
    }

    @inlinable
    public var unsafelyUnwrapped: Wrapped {
        @inline(__always)
        get {
            if let x = self {
                return x
            }
            preconditionFailure("unsafelyUnwrapped of nil optional")
        }
    }
}

extension Optional: Sendable where Wrapped: Sendable { }


/*
@frozen
public struct _OptionalNilComparisonType: ExpressibleByNilLiteral {
    @_transparent
    public init(nilLiteral: ()) { }
}

extension Optional {
    @_transparent
    public static func ~= (lhs: _OptionalNilComparisonType, rhs: Wrapped?) -> Bool {
        switch rhs {
        case .some:
            return false
        case .none:
            return true
        }
    }
    
    @_transparent
    public static func == (lhs: Wrapped?, rhs: _OptionalNilComparisonType) -> Bool {
        switch lhs {
        case .some:
            return false
        case .none:
            return true
        }
    }
    
    @_transparent
    public static func != (lhs: Wrapped?, rhs: _OptionalNilComparisonType) -> Bool {
        switch lhs {
        case .some:
            return true
        case .none:
            return false
        }
    }
    
    @_transparent
    public static func == (lhs: _OptionalNilComparisonType, rhs: Wrapped?) -> Bool {
        switch rhs {
            case .some:
            return false
            case .none:
            return true
        }
    }
    
    @_transparent
    public static func != (lhs: _OptionalNilComparisonType, rhs: Wrapped?) -> Bool {
    switch rhs {
    case .some:
      return true
    case .none:
      return false
    }
  }
}
*/