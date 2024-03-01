func alignedAlloc(size: Int, alignment: Int) -> UnsafeMutableRawPointer? {
    let alignment = max(alignment, MemoryLayout<UnsafeRawPointer>.size)
    var r: UnsafeMutableRawPointer? = nil
    //_ = memalign(&r, alignment, size)
    return r
}

@_cdecl("swift_slowAlloc")
public func swift_slowAlloc(_ size: Int, _ alignMask: Int) -> UnsafeMutableRawPointer? {
    let alignment: Int
    if alignMask == -1 {
        alignment = minAllocationAlignment()
    } else {
        alignment = alignMask + 1
    }
    return alignedAlloc(size: size, alignment: alignment)
}

@inlinable
@inline(__always)
internal func minAllocationAlignment() -> Int {
    return 16
}