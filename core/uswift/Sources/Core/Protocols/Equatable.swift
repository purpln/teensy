public protocol Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool
}

extension Equatable {
    @_transparent
    public static func != (lhs: Self, rhs: Self) -> Bool {
        return !(lhs == rhs)
    }
}

@_silgen_name("_swift_stdlib_Equatable_isEqual_indirect")
internal func Equatable_isEqual_indirect<T: Equatable>(
    _ lhs: UnsafePointer<T>,
    _ rhs: UnsafePointer<T>
) -> Bool {
    return lhs.pointee == rhs.pointee
}