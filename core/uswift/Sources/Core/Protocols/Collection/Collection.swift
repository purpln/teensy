public protocol Collection {
     associatedtype Index: Comparable

     func index(after: Index) -> Index
}
/*
public protocol Collection<Element>: Sequence {
    associatedtype Iterator
    
    associatedtype Index: Comparable
    associatedtype Indices: Collection where Indices.Element == Index, Indices.Index == Index, Indices.SubSequence == Indices
    associatedtype SubSequence: Collection where SubSequence.Index == Index, Element == SubSequence.Element, SubSequence.SubSequence == SubSequence
    
    var startIndex: Index { get }
    var endIndex: Index { get }
    
    var indices: Indices { get }
    var isEmpty: Bool { get }
    var count: Int { get }
    
    @_borrowed
    subscript(_: Index) -> Element { get }
    subscript(_: Range<Index>) -> SubSequence { get }
    
    func index(_: Index, offsetBy distance: Int) -> Index
    func index(_: Index, offsetBy distance: Int, limitedBy limit: Index) -> Index?
    func distance(from start: Index, to end: Index) -> Int
    
    func index(after: Index) -> Index
    func formIndex(after: inout Index)
    
    func _failEarlyRangeCheck(_ index: Index, bounds: Range<Index>)
    func _failEarlyRangeCheck(_ index: Index, bounds: ClosedRange<Index>)
    func _failEarlyRangeCheck(_ range: Range<Index>, bounds: Range<Index>)
}
*/