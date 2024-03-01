@_cdecl("test")
public func test(a: CDouble, b: CDouble) -> CDouble {
    let value: Double = 0
    another(value: value)
    return a - b
}

func another(value: Double) {
    let test: Any = Double(0)
}

@_cdecl("addition")
public func addition(a: CLong, b: CLong) -> CLong {
    a + b
}

@_cdecl("subtraction")
public func subtraction(a: CLong, b: CLong) -> CLong {
    a - b
}

@_cdecl("multiplication")
public func multiplication(a: CLong, b: CLong) -> CLong {
    a * b
}

@_cdecl("division")
public func division(a: CLong, b: CLong) -> CLong {
    a / b
}

@_cdecl("compare")
public func compare(a: CLong, b: CLong) -> CLong {
    (a == b) ? a : b
}

@_cdecl("greater")
public func greater(a: CLong, b: CLong) -> CLong {
    (a > b) ? a : b
}

@_cdecl("less")
public func less(a: CLong, b: CLong) -> CLong {
    (a < b) ? a : b
}