@frozen
public enum Never {}

extension Never: Sendable { }

extension Never: Error {}

extension Never: Equatable, Comparable, Hashable {}