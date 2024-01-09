public protocol IteratorProtocol {
  associatedtype Element

  mutating func next() -> Element?
}
