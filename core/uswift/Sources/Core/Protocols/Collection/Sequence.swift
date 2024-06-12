/*
public protocol IteratorProtocol {
    associatedtype Element
    
    mutating func next() -> Element?
}

public protocol Sequence {
    associatedtype Element
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Element
    
    __consuming func makeIterator() -> Iterator
    
    var underestimatedCount: Int { get }
}

extension Sequence where Self: IteratorProtocol {
    @_implements(Sequence, Iterator)
    public typealias DefaultIterator = Self
}

extension Sequence where Self.Iterator == Self {
    @inlinable
    public __consuming func makeIterator() -> Self {
        return self
    }
}
*/