public protocol Identifiable<ID> {
    associatedtype ID: Hashable
    var id: ID { get }
}

extension Identifiable where Self: AnyObject {
    public var id: ObjectIdentifier {
        return ObjectIdentifier(self)
    }
}