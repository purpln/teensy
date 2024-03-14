@frozen
public struct Hasher {
    @inlinable
    @inline(__always)
    public mutating func combine<H: Hashable>(_ value: H) {
        value.hash(into: &self)
    }
}
