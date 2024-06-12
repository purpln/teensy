@frozen
public enum Result<Success: ~Copyable, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

extension Result: Copyable /* where Success: Copyable */ {}

extension Result: Sendable where Success: Sendable & ~Copyable {}

extension Result: Equatable where Success: Equatable, Failure: Equatable {}

extension Result: Hashable where Success: Hashable, Failure: Hashable {}

extension Result {
    @_alwaysEmitIntoClient
    @_disfavoredOverload
    public func map<NewSuccess: ~Copyable>(
        _ transform: (Success) -> NewSuccess
    ) -> Result<NewSuccess, Failure> {
        switch self {
        case let .success(success):
            return .success(transform(success))
        case let .failure(failure):
            return .failure(failure)
        }
    }
    
    @_spi(SwiftStdlibLegacyABI) @available(swift, obsoleted: 1)
    @_silgen_name("$ss6ResultO3mapyAByqd__q_Gqd__xXElF")
    @usableFromInline
    internal func __abi_map<NewSuccess>(
        _ transform: (Success) -> NewSuccess
    ) -> Result<NewSuccess, Failure> {
        switch self {
        case let .success(success):
            return .success(transform(success))
        case let .failure(failure):
            return .failure(failure)
        }
    }
}

@_disallowFeatureSuppression(NoncopyableGenerics)
extension Result where Success: ~Copyable {
    @_alwaysEmitIntoClient
    public consuming func _consumingMap<NewSuccess: ~Copyable>(
        _ transform: (consuming Success) -> NewSuccess
    ) -> Result<NewSuccess, Failure> {
        switch consume self {
        case let .success(success):
            return .success(transform(consume success))
        case let .failure(failure):
            return .failure(consume failure)
        }
    }
    
    @_alwaysEmitIntoClient
    public borrowing func _borrowingMap<NewSuccess: ~Copyable>(
        _ transform: (borrowing Success) -> NewSuccess
    ) -> Result<NewSuccess, Failure> {
        switch self {
        case .success(borrowing success):
            return .success(transform(success))
        case let .failure(failure):
            return .failure(failure)
        }
    }
}

extension Result where Success: ~Copyable {
    @_alwaysEmitIntoClient
    public consuming func mapError<NewFailure>(
        _ transform: (Failure) -> NewFailure
    ) -> Result<Success, NewFailure> {
        switch consume self {
        case let .success(success):
            return .success(consume success)
        case let .failure(failure):
            return .failure(transform(failure))
        }
    }
}

@_disallowFeatureSuppression(NoncopyableGenerics)
extension Result {
    @_spi(SwiftStdlibLegacyABI) @available(swift, obsoleted: 1)
    @usableFromInline
    internal func mapError<NewFailure>(
        _ transform: (Failure) -> NewFailure
    ) -> Result<Success, NewFailure> {
        switch self {
        case let .success(success):
            return .success(success)
        case let .failure(failure):
            return .failure(transform(failure))
        }
    }
}

extension Result {
    @_alwaysEmitIntoClient
    @_disfavoredOverload
    public func flatMap<NewSuccess: ~Copyable>(
        _ transform: (Success) -> Result<NewSuccess, Failure>
    ) -> Result<NewSuccess, Failure> {
        switch self {
        case let .success(success):
            return transform(success)
        case let .failure(failure):
            return .failure(failure)
        }
    }
    
    @_spi(SwiftStdlibLegacyABI) @available(swift, obsoleted: 1)
    @_silgen_name("$ss6ResultO7flatMapyAByqd__q_GADxXElF")
    @usableFromInline
    internal func __abi_flatMap<NewSuccess>(
        _ transform: (Success) -> Result<NewSuccess, Failure>
    ) -> Result<NewSuccess, Failure> {
        switch self {
        case let .success(success):
            return transform(success)
        case let .failure(failure):
            return .failure(failure)
        }
    }
}

@_disallowFeatureSuppression(NoncopyableGenerics)
extension Result where Success: ~Copyable {
    @_alwaysEmitIntoClient
    public consuming func _consumingFlatMap<NewSuccess: ~Copyable>(
        _ transform: (consuming Success) -> Result<NewSuccess, Failure>
    ) -> Result<NewSuccess, Failure> {
        switch consume self {
        case let .success(success):
            return transform(consume success)
        case let .failure(failure):
            return .failure(failure)
        }
    }
    
    @_alwaysEmitIntoClient
    public borrowing func _borrowingFlatMap<NewSuccess: ~Copyable>(
        _ transform: (borrowing Success) -> Result<NewSuccess, Failure>
    ) -> Result<NewSuccess, Failure> {
        switch self {
        case .success(borrowing success):
            return transform(success)
        case let .failure(failure):
            return .failure(failure)
        }
    }
}

extension Result where Success: ~Copyable {
    @_alwaysEmitIntoClient
    public consuming func flatMapError<NewFailure>(
        _ transform: (Failure) -> Result<Success, NewFailure>
    ) -> Result<Success, NewFailure> {
        switch consume self {
        case let .success(success):
            return .success(success)
        case let .failure(failure):
            return transform(failure)
        }
    }
}

extension Result {
    @_spi(SwiftStdlibLegacyABI) @available(swift, obsoleted: 1)
    @_silgen_name("$ss6ResultO12flatMapErroryAByxqd__GADq_XEs0D0Rd__lF")
    @usableFromInline
    internal func __abi_flatMapError<NewFailure>(
        _ transform: (Failure) -> Result<Success, NewFailure>
    ) -> Result<Success, NewFailure> {
        switch self {
        case let .success(success):
            return .success(success)
        case let .failure(failure):
            return transform(failure)
        }
    }
}
/*
extension Result where Success: ~Copyable {
    @_alwaysEmitIntoClient
    public consuming func get() throws(Failure) -> Success {
        switch consume self {
        case let .success(success):
            return success
        case let .failure(failure):
            throw failure
        }
    }
}
*/
extension Result where Success: ~Copyable {
    @_alwaysEmitIntoClient
    public init(catching body: () throws(Failure) -> Success) {
        do {
            self = .success(try body())
        } catch {
            self = .failure(error)
        }
    }
}

extension Result {
    @_spi(SwiftStdlibLegacyABI) @available(swift, obsoleted: 1)
    @_silgen_name("$ss6ResultO3getxyKF")
    @usableFromInline
    func __abi_get() throws -> Success {
        switch self {
        case let .success(success):
            return success
        case let .failure(failure):
            throw failure
        }
    }
    
}

extension Result where Failure == Swift.Error {
    @_spi(SwiftStdlibLegacyABI) @available(swift, obsoleted: 1)
    @_silgen_name("$ss6ResultOss5Error_pRs_rlE8catchingAByxsAC_pGxyKXE_tcfC")
    @usableFromInline
    init(__abi_catching body: () throws(Failure) -> Success) {
        do {
            self = .success(try body())
        } catch {
            self = .failure(error)
        }
    }
}
