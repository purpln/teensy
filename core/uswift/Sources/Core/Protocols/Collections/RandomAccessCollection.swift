/*
public protocol RandomAccessCollection<Element>: BidirectionalCollection where SubSequence: RandomAccessCollection, Indices: RandomAccessCollection {
    override associatedtype Element
    override associatedtype Index
    override associatedtype SubSequence
    override associatedtype Indices
    
    override var indices: Indices { get }

    override subscript(bounds: Range<Index>) -> SubSequence { get }
    
    @_borrowed
    override subscript(position: Index) -> Element { get }
    override var startIndex: Index { get }
    override var endIndex: Index { get }
    
    override func index(before i: Index) -> Index
    override func formIndex(before i: inout Index)
    override func index(after i: Index) -> Index
    override func formIndex(after i: inout Index)
    @_nonoverride func index(_ i: Index, offsetBy distance: Int) -> Index
    @_nonoverride func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index?
    @_nonoverride func distance(from start: Index, to end: Index) -> Int
}

extension RandomAccessCollection {
    @inlinable
    public func index(_ i: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index? {
        let l = self.distance(from: i, to: limit)
        if distance > 0 ? l >= 0 && l < distance : l <= 0 && distance < l {
            return nil
        }
        return index(i, offsetBy: distance)
    }
}

extension RandomAccessCollection where Index: Strideable, Index.Stride == Int {
    @_implements(Collection, Indices)
    public typealias _Default_Indices = Range<Index>
}

extension RandomAccessCollection where Index: Strideable, Index.Stride == Int, Indices == Range<Index> {
    @inlinable
    public var indices: Range<Index> {
        return startIndex..<endIndex
    }
    
    @inlinable
    public func index(after i: Index) -> Index {
        _failEarlyRangeCheck(i, bounds: Range(uncheckedBounds: (startIndex, endIndex)))
        return i.advanced(by: 1)
    }
    
    @inlinable
    public func index(before i: Index) -> Index {
        let result = i.advanced(by: -1)
        _failEarlyRangeCheck(result, bounds: Range(uncheckedBounds: (startIndex, endIndex)))
        return result
    }
    
    @inlinable
    public func index(_ i: Index, offsetBy distance: Index.Stride) -> Index {
        let result = i.advanced(by: distance)
        _failEarlyRangeCheck(result, bounds: ClosedRange(uncheckedBounds: (startIndex, endIndex)))
        return result
    }
    
    @inlinable
    public func distance(from start: Index, to end: Index) -> Index.Stride {
        _failEarlyRangeCheck(start, bounds: ClosedRange(uncheckedBounds: (startIndex, endIndex)))
        _failEarlyRangeCheck(end, bounds: ClosedRange(uncheckedBounds: (startIndex, endIndex)))
        return start.distance(to: end)
    }
}
*/
