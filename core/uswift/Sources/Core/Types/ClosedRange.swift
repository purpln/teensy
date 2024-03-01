@frozen
public struct ClosedRange<Bound: Comparable> {
    public let lowerBound: Bound
    public let upperBound: Bound

    @_alwaysEmitIntoClient
    @inline(__always)
    internal init(_uncheckedBounds bounds: (lower: Bound, upper: Bound)) {
        lowerBound = bounds.lower
        upperBound = bounds.upper
    }

    @inlinable
    public init(uncheckedBounds bounds: (lower: Bound, upper: Bound)) {
        precondition(bounds.lower <= bounds.upper, "ClosedRange requires lowerBound <= upperBound")
        self.init(_uncheckedBounds: (lower: bounds.lower, upper: bounds.upper))
    }
}