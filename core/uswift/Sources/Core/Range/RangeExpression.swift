public protocol RangeExpression {
    associatedtype Bound: Comparable
    
    func relative<C: Collection>(to collection: C) -> Range<Bound> where C.Index == Bound
    func contains(_ element: Bound) -> Bool
}

extension RangeExpression {
    @inlinable
    public static func ~= (_ pattern: Self, _ value: Bound) -> Bool {
        return pattern.contains(value)
    }
}
