@frozen
public enum FloatingPointSign: Int {
    case plus
    case minus
    
    @inlinable
    public init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .plus
        case 1: self = .minus
        default: return nil
        }
    }
    
    @inlinable
    public var rawValue: Int {
        switch self {
        case .plus: return 0
        case .minus: return 1
        }
    }
    
    @_transparent
    @inlinable
    public static func == (a: FloatingPointSign, b: FloatingPointSign) -> Bool {
        return a.rawValue == b.rawValue
    }
}
