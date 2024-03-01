extension ExpressibleByFloatLiteral where Self: _ExpressibleByBuiltinFloatLiteral {
    @_transparent
    public init(floatLiteral value: Self) {
        self = value
    }
}
