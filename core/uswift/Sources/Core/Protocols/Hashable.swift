public protocol Hashable: Equatable {
    //var hashValue: Int { get }

    //func hash(into hasher: inout Hasher)
}

/*
@_silgen_name("_swift_stdlib_Hashable_isEqual_indirect")
internal func Hashable_isEqual_indirect<T: Hashable>(
    lhs: UnsafePointer<T>,
    rhs: UnsafePointer<T>
) -> Bool {
    return lhs.pointee == rhs.pointee
}

@_silgen_name("_swift_stdlib_Hashable_hashValue_indirect")
internal func Hashable_hashValue_indirect<T: Hashable>(
    _ value: UnsafePointer<T>
) -> Int {
    return value.pointee.hashValue
}
*/