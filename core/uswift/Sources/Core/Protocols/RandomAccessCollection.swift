public protocol RandomAccessCollection<Element>: BidirectionalCollection where SubSequence: RandomAccessCollection, Indices: RandomAccessCollection {
    override associatedtype Element
    override associatedtype Index
    override associatedtype SubSequence
    override associatedtype Indices
    
}