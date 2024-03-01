/*
@inlinable
public func abs<T: SignedNumeric & Comparable>(_ x: T) -> T {
    if T.self == T.Magnitude.self {
        return unsafeBitCast(x.magnitude, to: T.self)
    }
    return x < (0 as T) ? -x : x
}
*/