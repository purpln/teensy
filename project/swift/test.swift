@_cdecl("test")
public func test(a: Double, b: Double) -> Double {
    a / b
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

enum Failure: Error {
    case fault
}

@main
struct Application {
    static func main() throws {
        throw Failure.fault
        //precondition(false, "failure")
    }
}