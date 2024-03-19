// Bool
public protocol _ExpressibleByBuiltinBooleanLiteral {
    init(_builtinBooleanLiteral value: Builtin.Int1)
}

public protocol ExpressibleByBooleanLiteral {
    associatedtype BooleanLiteralType: _ExpressibleByBuiltinBooleanLiteral
    init(booleanLiteral value: BooleanLiteralType)
}

// Float
public protocol _ExpressibleByBuiltinFloatLiteral {
    init(_builtinFloatLiteral value: MaxBuiltinFloatType)
}

public protocol ExpressibleByFloatLiteral {
    associatedtype FloatLiteralType: _ExpressibleByBuiltinFloatLiteral
    init(floatLiteral value: FloatLiteralType)
}

// Int
public protocol _ExpressibleByBuiltinIntegerLiteral {
    init(_builtinIntegerLiteral value: Builtin.IntLiteral)
}

public protocol ExpressibleByIntegerLiteral {
    associatedtype IntegerLiteralType: _ExpressibleByBuiltinIntegerLiteral
    init(integerLiteral value: IntegerLiteralType)
}

// String
public protocol _ExpressibleByBuiltinStringLiteral {
    init(_builtinStringLiteral start: Builtin.RawPointer, utf8CodeUnitCount: Builtin.Word, isASCII: Builtin.Int1)
}

public protocol ExpressibleByStringLiteral {
    associatedtype StringLiteralType: _ExpressibleByBuiltinStringLiteral
    init(stringLiteral value: StringLiteralType)
}

// Optional
public protocol ExpressibleByNilLiteral {
    init(nilLiteral: ())
}

/*
// Array
public protocol ExpressibleByArrayLiteral {
    associatedtype ArrayLiteralElement
    init(arrayLiteral elements: ArrayLiteralElement...)
}

// Dictonary
public protocol ExpressibleByDictionaryLiteral {
    associatedtype Key
    associatedtype Value
    init(dictionaryLiteral elements: (Key, Value)...)
}
*/

public protocol RawRepresentable<RawValue> {
    associatedtype RawValue
    init?(rawValue: RawValue)
    var rawValue: RawValue { get }
}

@inlinable
public func == <T: RawRepresentable>(lhs: T, rhs: T) -> Bool where T.RawValue: Equatable {
    return lhs.rawValue == rhs.rawValue
}

public func != <T: RawRepresentable>(lhs: T, rhs: T) -> Bool where T.RawValue: Equatable {
    return lhs.rawValue != rhs.rawValue
}

public func != <T: Equatable>(lhs: T, rhs: T) -> Bool where T: RawRepresentable, T.RawValue: Equatable {
    return lhs.rawValue != rhs.rawValue
}

@_transparent
public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T) rethrows -> T {
    switch optional {
    case .some(let value):
        return value
    case .none:
        return try defaultValue()
    }
}

@_transparent
public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T?) rethrows -> T? {
    switch optional {
    case .some(let value):
        return value
    case .none:
        return try defaultValue()
    }
}
