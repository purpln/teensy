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
/*
extension Range: Sequence where Bound: Strideable, Bound.Stride: SignedInteger {
    public typealias Element = Bound
    public typealias Iterator = IndexingIterator<Range<Bound>>
}

extension Range: Collection, BidirectionalCollection, RandomAccessCollection where Bound: Strideable, Bound.Stride: SignedInteger {
    public typealias Index = Bound
    public typealias Indices = Range<Bound>
    public typealias SubSequence = Range<Bound>
    
    @inlinable
    public var startIndex: Index { return lowerBound }
    
    @inlinable
    public var endIndex: Index { return upperBound }
    
    @inlinable
    @inline(__always)
    public func index(after i: Index) -> Index {
        _failEarlyRangeCheck(i, bounds: startIndex..<endIndex)
        
        return i.advanced(by: 1)
    }
    
    @inlinable
    public func index(before i: Index) -> Index {
        precondition(i > lowerBound)
        precondition(i <= upperBound)
        
        return i.advanced(by: -1)
    }
    
    @inlinable
    public func index(_ i: Index, offsetBy n: Int) -> Index {
        let r = i.advanced(by: numericCast(n))
        precondition(r >= lowerBound)
        precondition(r <= upperBound)
        return r
    }
    
    @inlinable
    public func distance(from start: Index, to end: Index) -> Int {
        return numericCast(start.distance(to: end))
    }
    
    /// Accesses the subsequence bounded by the given range.
    ///
    /// - Parameter bounds: A range of the range's indices. The upper and lower
    ///   bounds of the `bounds` range must be valid indices of the collection.
    @inlinable
    public subscript(bounds: Range<Index>) -> Range<Bound> {
        return bounds
    }
    
    /// The indices that are valid for subscripting the range, in ascending
    /// order.
    @inlinable
    public var indices: Indices {
        return self
    }
    
    @inlinable
    public func _customContainsEquatableElement(_ element: Element) -> Bool? {
        return lowerBound <= element && element < upperBound
    }
    
    @inlinable
    public func _customIndexOfEquatableElement(_ element: Bound) -> Index?? {
        return lowerBound <= element && element < upperBound ? element : nil
    }
    
    @inlinable
    public func _customLastIndexOfEquatableElement(_ element: Bound) -> Index?? {
        // The first and last elements are the same because each element is unique.
        return _customIndexOfEquatableElement(element)
    }
    
    @inlinable
    public subscript(position: Index) -> Element {
        precondition(self.contains(position), "Index out of range")
        return position
    }
}
*/
