public protocol Strideable<Stride>: Comparable {
    associatedtype Stride: SignedNumeric, Comparable
    
    func distance(to other: Self) -> Stride
    func advanced(by n: Stride) -> Self
}
