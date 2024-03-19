public func ~= <T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}

precedencegroup AssignmentPrecedence {
    assignment: true
    associativity: right
}
precedencegroup FunctionArrowPrecedence {
    associativity: right
    higherThan: AssignmentPrecedence
}
precedencegroup TernaryPrecedence {
    associativity: right
    higherThan: FunctionArrowPrecedence
}
precedencegroup DefaultPrecedence {
    higherThan: TernaryPrecedence
}
precedencegroup LogicalDisjunctionPrecedence {
    associativity: left
    higherThan: TernaryPrecedence
}
precedencegroup LogicalConjunctionPrecedence {
    associativity: left
    higherThan: LogicalDisjunctionPrecedence
}
precedencegroup ComparisonPrecedence {
    higherThan: LogicalConjunctionPrecedence
}
precedencegroup NilCoalescingPrecedence {
    associativity: right
    higherThan: ComparisonPrecedence
}
precedencegroup CastingPrecedence {
    higherThan: NilCoalescingPrecedence
}
precedencegroup RangeFormationPrecedence {
    higherThan: CastingPrecedence
}
precedencegroup AdditionPrecedence {
    associativity: left
    higherThan: RangeFormationPrecedence
}
precedencegroup MultiplicationPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}
precedencegroup BitwiseShiftPrecedence {
    higherThan: MultiplicationPrecedence
}

// Standard postfix operators.
postfix operator ++
postfix operator --
postfix operator ...

// Standard prefix operators.
prefix operator ++
prefix operator --
prefix operator !
prefix operator ~
prefix operator +
prefix operator -
prefix operator ...
prefix operator ..<

// "Exponentiative"
infix operator  <<: BitwiseShiftPrecedence
infix operator &<<: BitwiseShiftPrecedence
infix operator  >>: BitwiseShiftPrecedence
infix operator &>>: BitwiseShiftPrecedence

// "Multiplicative"
infix operator   *: MultiplicationPrecedence
infix operator  &*: MultiplicationPrecedence
infix operator   /: MultiplicationPrecedence
infix operator   %: MultiplicationPrecedence
infix operator   &: MultiplicationPrecedence

// "Additive"
infix operator   +: AdditionPrecedence
infix operator  &+: AdditionPrecedence
infix operator   -: AdditionPrecedence
infix operator  &-: AdditionPrecedence
infix operator   |: AdditionPrecedence
infix operator   ^: AdditionPrecedence

infix operator  ...: RangeFormationPrecedence
infix operator  ..<: RangeFormationPrecedence

// "Coalescing"
infix operator ??: NilCoalescingPrecedence

// "Comparative"
infix operator   <: ComparisonPrecedence
infix operator  <=: ComparisonPrecedence
infix operator   >: ComparisonPrecedence
infix operator  >=: ComparisonPrecedence
infix operator  ==: ComparisonPrecedence
infix operator  !=: ComparisonPrecedence
infix operator ===: ComparisonPrecedence
infix operator !==: ComparisonPrecedence
infix operator  ~=: ComparisonPrecedence

// "Conjunctive"
infix operator &&: LogicalConjunctionPrecedence

// "Disjunctive"
infix operator ||: LogicalDisjunctionPrecedence

// Compound
infix operator   *=: AssignmentPrecedence
infix operator  &*=: AssignmentPrecedence
infix operator   /=: AssignmentPrecedence
infix operator   %=: AssignmentPrecedence
infix operator   +=: AssignmentPrecedence
infix operator  &+=: AssignmentPrecedence
infix operator   -=: AssignmentPrecedence
infix operator  &-=: AssignmentPrecedence
infix operator  <<=: AssignmentPrecedence
infix operator &<<=: AssignmentPrecedence
infix operator  >>=: AssignmentPrecedence
infix operator &>>=: AssignmentPrecedence
infix operator   &=: AssignmentPrecedence
infix operator   ^=: AssignmentPrecedence
infix operator   |=: AssignmentPrecedence

infix operator ~>