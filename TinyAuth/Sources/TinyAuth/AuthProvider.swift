// MARK: - AuthProvider

public typealias AuthProvider<Auth, Failure> = (
    _ completion: @escaping (Result<Auth, Failure>) -> Void
)
-> AuthTask
where Failure: Error
