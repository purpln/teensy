public protocol _ExpressibleByBuiltinBooleanLiteral {
  init(_builtinBooleanLiteral value: Builtin.Int1)
}

public protocol ExpressibleByBooleanLiteral {
  associatedtype BooleanLiteralType: _ExpressibleByBuiltinBooleanLiteral
  init(booleanLiteral value: BooleanLiteralType)
}

public protocol _ExpressibleByBuiltinFloatLiteral {
  init(_builtinFloatLiteral value: _MaxBuiltinFloatType)
}

public protocol ExpressibleByFloatLiteral {
  associatedtype FloatLiteralType: _ExpressibleByBuiltinFloatLiteral
  init(floatLiteral value: FloatLiteralType)
}

public protocol _ExpressibleByBuiltinIntegerLiteral {
  init(_builtinIntegerLiteral value: Builtin.IntLiteral)
}

public protocol ExpressibleByIntegerLiteral {
  associatedtype IntegerLiteralType: _ExpressibleByBuiltinIntegerLiteral
  init(integerLiteral value: IntegerLiteralType)
}

public protocol _ExpressibleByBuiltinStringLiteral {
  init(_builtinStringLiteral start: Builtin.RawPointer,
       utf8CodeUnitCount: Builtin.Word, isASCII: Builtin.Int1)
}

public protocol ExpressibleByStringLiteral {
  associatedtype StringLiteralType: _ExpressibleByBuiltinStringLiteral

  init(stringLiteral value: StringLiteralType)
}

public protocol ExpressibleByNilLiteral {
  init(nilLiteral: ())
}

public protocol RawRepresentable<RawValue> {
  associatedtype RawValue
  var rawValue: RawValue { get }
  init?(rawValue: RawValue)
}

/*
public protocol ExpressibleByArrayLiteral {
  associatedtype ArrayLiteralElement
  init(arrayLiteral elements: ArrayLiteralElement...)
}

public protocol ExpressibleByDictionaryLiteral {
  associatedtype Key
  associatedtype Value
  init(dictionaryLiteral elements: (Key, Value)...)
}



@inlinable
public func == <T: RawRepresentable>(lhs: T, rhs: T) -> Bool
  where T.RawValue: Equatable {
  return lhs.rawValue == rhs.rawValue
}

public func != <T: RawRepresentable>(lhs: T, rhs: T) -> Bool
  where T.RawValue: Equatable {
  return lhs.rawValue != rhs.rawValue
}

public func != <T: Equatable>(lhs: T, rhs: T) -> Bool
  where T: RawRepresentable, T.RawValue: Equatable {
  return lhs.rawValue != rhs.rawValue
}
*/
