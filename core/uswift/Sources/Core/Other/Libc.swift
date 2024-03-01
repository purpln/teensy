@_silgen_name("malloc") @usableFromInline
internal func malloc(_: Int32)

@_silgen_name("memalign") @usableFromInline
internal func memalign(_: UnsafeMutablePointer<UnsafeMutableRawPointer?>, _: Int, _: Int) -> CInt

@_silgen_name("free") @usableFromInline
func free(_: Builtin.RawPointer)

@_silgen_name("max") @usableFromInline
internal func max(_: Int, _: Int) -> Int
