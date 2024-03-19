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

extension ClosedRange {
    @inlinable
    public var isEmpty: Bool {
        return false
    }
}

extension ClosedRange: RangeExpression {
    @inlinable
    public func relative<C: Collection>(to collection: C) -> Range<Bound>
    where C.Index == Bound {
        return Range(_uncheckedBounds: (lower: lowerBound, upper: collection.index(after: self.upperBound)))
    }
    
    @inlinable
    public func contains(_ element: Bound) -> Bool {
        return element >= self.lowerBound && element <= self.upperBound
    }
}

extension ClosedRange where Bound: Strideable, Bound.Stride: SignedInteger {
    @frozen
    public enum Index {
        case pastEnd
        case inRange(Bound)
    }
}

extension ClosedRange.Index: Comparable {
    @inlinable
    public static func == (lhs: ClosedRange<Bound>.Index, rhs: ClosedRange<Bound>.Index) -> Bool {
        switch (lhs, rhs) {
        case (.inRange(let l), .inRange(let r)):
            return l == r
        case (.pastEnd, .pastEnd):
            return true
        default:
            return false
        }
    }
    
    @inlinable
    public static func < (lhs: ClosedRange<Bound>.Index, rhs: ClosedRange<Bound>.Index) -> Bool {
        switch (lhs, rhs) {
        case (.inRange(let l), .inRange(let r)):
            return l < r
        case (.inRange, .pastEnd):
            return true
        default:
            return false
        }
    }
}

extension ClosedRange.Index: Hashable where Bound: Strideable, Bound.Stride: SignedInteger, Bound: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .inRange(let value):
            hasher.combine(0 as Int8)
            hasher.combine(value)
        case .pastEnd:
            hasher.combine(1 as Int8)
        }
    }
}

extension ClosedRange: Equatable {
    @inlinable
    public static func == (lhs: ClosedRange<Bound>, rhs: ClosedRange<Bound>) -> Bool {
        return lhs.lowerBound == rhs.lowerBound && lhs.upperBound == rhs.upperBound
    }
}

extension ClosedRange: Hashable where Bound: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(lowerBound)
        hasher.combine(upperBound)
    }
}

extension ClosedRange {
    @inlinable
    @inline(__always)
    public func clamped(to limits: ClosedRange) -> ClosedRange {
        let lower =
            limits.lowerBound > self.lowerBound ? limits.lowerBound
                : limits.upperBound < self.lowerBound ? limits.upperBound
                : self.lowerBound
        let upper =
            limits.upperBound < self.upperBound ? limits.upperBound
                : limits.lowerBound > self.upperBound ? limits.lowerBound
                : self.upperBound
        return ClosedRange(_uncheckedBounds: (lower: lower, upper: upper))
    }
}
