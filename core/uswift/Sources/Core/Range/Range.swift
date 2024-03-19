@frozen
public struct Range<Bound: Comparable> {
    public let lowerBound: Bound
    public let upperBound: Bound
    
    @_alwaysEmitIntoClient
    @inline(__always)
    init(_uncheckedBounds bounds: (lower: Bound, upper: Bound)) {
        lowerBound = bounds.lower
        upperBound = bounds.upper
    }
    
    @inlinable
    public init(uncheckedBounds bounds: (lower: Bound, upper: Bound)) {
        precondition(bounds.lower <= bounds.upper, "Range requires lowerBound <= upperBound")
        self.init(_uncheckedBounds: (lower: bounds.lower, upper: bounds.upper))
    }
    
    @inlinable
    public func contains(_ element: Bound) -> Bool {
        return lowerBound <= element && element < upperBound
    }
    
    @inlinable
    public var isEmpty: Bool {
        return lowerBound == upperBound
    }
}

extension Range: RangeExpression {
    @inlinable
    public func relative<C: Collection>(to _: C) -> Range<Bound> where C.Index == Bound {
        return self
    }
}

extension Range: Equatable {
    @inlinable
    public static func == (lhs: Range<Bound>, rhs: Range<Bound>) -> Bool {
        return lhs.lowerBound == rhs.lowerBound && lhs.upperBound == rhs.upperBound
    }
}

extension Range: Hashable where Bound: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(lowerBound)
        hasher.combine(upperBound)
    }
}

extension Range {
    @inlinable
    @inline(__always)
    public func clamped(to limits: Range) -> Range {
        let lower =
            limits.lowerBound > self.lowerBound ? limits.lowerBound
                : limits.upperBound < self.lowerBound ? limits.upperBound
                : self.lowerBound
        let upper =
            limits.upperBound < self.upperBound ? limits.upperBound
                : limits.lowerBound > self.upperBound ? limits.lowerBound
                : self.upperBound
        return Range(_uncheckedBounds: (lower: lower, upper: upper))
    }
}
