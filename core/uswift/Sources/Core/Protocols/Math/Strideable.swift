public protocol Strideable<Stride>: Comparable {
    associatedtype Stride: SignedNumeric, Comparable
    
    func distance(to other: Self) -> Stride
    func advanced(by n: Stride) -> Self
    
    static func _step(
        after current: (index: Int?, value: Self),
        from start: Self, by distance: Self.Stride
    ) -> (index: Int?, value: Self)
}

extension Strideable {
    @inlinable
    public static func < (x: Self, y: Self) -> Bool {
        return x.distance(to: y) > 0
    }
    
    @inlinable
    public static func == (x: Self, y: Self) -> Bool {
        return x.distance(to: y) == 0
    }
}

extension Strideable {
    @inlinable
    public static func _step(
        after current: (index: Int?, value: Self),
        from start: Self, by distance: Self.Stride
    ) -> (index: Int?, value: Self) {
        return (nil, current.value.advanced(by: distance))
    }
}
/*
extension Strideable where Self: FixedWidthInteger & SignedInteger {
    @_alwaysEmitIntoClient
    public static func _step(
        after current: (index: Int?, value: Self),
        from start: Self, by distance: Self.Stride
    ) -> (index: Int?, value: Self) {
        let value = current.value
        let (partialValue, overflow) =
        Self.bitWidth >= Self.Stride.bitWidth ||
            (value < (0 as Self)) == (distance < (0 as Self.Stride))
            ? value.addingReportingOverflow(Self(distance))
            : (Self(Self.Stride(value) + distance), false)
        return overflow
            ? (.min, distance < (0 as Self.Stride) ? .min : .max)
            : (nil, partialValue)
    }
}

extension Strideable where Self: FixedWidthInteger & UnsignedInteger {
    @_alwaysEmitIntoClient
    public static func _step(
        after current: (index: Int?, value: Self),
        from start: Self, by distance: Self.Stride
    ) -> (index: Int?, value: Self) {
        let (partialValue, overflow) = distance < (0 as Self.Stride)
            ? current.value.subtractingReportingOverflow(Self(-distance))
            : current.value.addingReportingOverflow(Self(distance))
        return overflow
            ? (.min, distance < (0 as Self.Stride) ? .min : .max)
            : (nil, partialValue)
    }
}

extension Strideable where Stride: FloatingPoint {
    @inlinable // protocol-only
    public static func _step(
        after current: (index: Int?, value: Self),
        from start: Self, by distance: Self.Stride
    ) -> (index: Int?, value: Self) {
        if let i = current.index {
            // When Stride is a floating-point type, we should avoid accumulating
            // rounding error from repeated addition.
            return (i + 1, start.advanced(by: Stride(i + 1) * distance))
        }
        return (nil, current.value.advanced(by: distance))
    }
}

extension Strideable where Self: FloatingPoint, Self == Stride {
    @inlinable // protocol-only
    public static func _step(
        after current: (index: Int?, value: Self),
        from start: Self, by distance: Self.Stride
    ) -> (index: Int?, value: Self) {
        if let i = current.index {
            // When both Self and Stride are the same floating-point type, we should
            // take advantage of fused multiply-add (where supported) to eliminate
            // intermediate rounding error.
            return (i + 1, start.addingProduct(Stride(i + 1), distance))
        }
        return (nil, current.value.advanced(by: distance))
    }
}
*/
