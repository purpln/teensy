public protocol Sequence {
    associatedtype Element
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Element
    
    __consuming func makeIterator() -> Iterator
    
    var underestimatedCount: Int { get }
}
