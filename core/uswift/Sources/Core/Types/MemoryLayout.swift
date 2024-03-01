public enum MemoryLayout<T> {
    @_transparent
    public static var size: Int {
        return Int(Builtin.sizeof(T.self))
    }
    
    @_transparent
    public static var stride: Int {
        return Int(Builtin.strideof(T.self))
    }
    
    @_transparent
    public static var alignment: Int {
        return Int(Builtin.alignof(T.self))
    }
}