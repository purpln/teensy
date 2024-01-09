//public typealias Float32 = Float
//public typealias Float64 = Double

public typealias IntegerLiteralType = Int
//public typealias FloatLiteralType = Double

public typealias BooleanLiteralType = Bool

//public typealias StringLiteralType = String

public typealias AnyObject = Builtin.AnyObject

public typealias AnyClass = AnyObject.Type


#if arch(arm64) || arch(powerpc64)
  public typealias _MaxBuiltinFloatType = Builtin.FPIEEE128
#elseif !(os(Windows) || os(Android)) && (arch(i386) || arch(x86_64))
  public typealias _MaxBuiltinFloatType = Builtin.FPIEEE80
#else
  public typealias _MaxBuiltinFloatType = Builtin.FPIEEE64
#endif
