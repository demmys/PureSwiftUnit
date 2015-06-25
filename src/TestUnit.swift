public class TestUnit {
    let description: String
    var testCases: [TestCase] = []

    public init(_ description: String) {
        self.description = description
    }

    public func setUp() {}
    public func tearDown() {}
    public func beforeCase() {}
    public func afterCase() {}

    public func setTestCases(tests: [(String, () throws -> ())]) {
        self.testCases = []
        for (d, t) in tests {
            self.testCases.append(TestCase(manager: self, test: t, description: d))
        }
    }

    public func isTrue(t: String, _ v: Bool) throws {
        guard v else {
            throw FailureReason.ExpectedTrue(t)
        }
    }

    public func isFalse(t: String, _ v: Bool) throws {
        guard !v else {
            throw FailureReason.ExpectedFalse(t)
        }
    }

    public func equals<T: Equatable>(t: String, _ l: T, _ r: T) throws {
        guard l == r else {
            throw FailureReason.ExpectedEqual(t, String(l), String(r))
        }
    }

    public func notEquals<T: Equatable>(t: String, _ l: T, _ r: T) throws {
        guard l != r else {
            throw FailureReason.ExpectedNotEqual(t, String(l), String(r))
        }
    }

    public func isNil<T>(t: String, _ v: T?) throws {
        guard v == nil else {
            throw FailureReason.ExpectedNil(t, String(v))
        }
    }

    public func isNotNil<T>(t: String, _ v: T?) throws {
        guard let _ = v else {
            throw FailureReason.ExpectedNotNil(t)
        }
    }
}

public enum FailureReason : ErrorType {
    case Unexpected
    case Text(String)
    case ExpectedTrue(String)
    case ExpectedFalse(String)
    case ExpectedEqual(String, String, String)
    case ExpectedNotEqual(String, String, String)
    case ExpectedNil(String, String)
    case ExpectedNotNil(String)

    public func stringify() -> String {
        switch self {
        case .Unexpected:
            return "unexpected error occured"
        case let .Text(t):
            return t
        case let .ExpectedTrue(t):
            return template(t, "true", "false")
        case let .ExpectedFalse(t):
            return template(t, "false", "true")
        case let .ExpectedEqual(t, l, r):
            return template(t, l, r)
        case let .ExpectedNotEqual(t, l, r):
            return template(t, l, r)
        case let .ExpectedNil(t, v):
            return template(t, "nil", v)
        case let .ExpectedNotNil(t):
            return template(t, "not nil", "nil")
        }
    }

    private func template(t: String, _ e: String, _ a: String) -> String {
        return "expected \(t) to \(e) but actual is \(a)"
    }
}

public enum PendingReason : ErrorType {
    case Text(String)

    func stringify() -> String {
        switch self {
        case let .Text(s):
            return s
        }
    }
}

public enum TestResult {
    case Success
    case Failure(FailureReason)
    case Pending(PendingReason)
}

public class TestCase {
    private let manager: TestUnit
    private let test: () throws -> ()
    public let description: String

    public init(
        manager: TestUnit, test: () throws -> (), description: String
    ) {
        self.manager = manager
        self.test = test
        self.description = description
    }

    internal func run() -> TestResult {
        manager.beforeCase()
        do {
            try test()
            manager.afterCase()
            return .Success
        } catch let f as FailureReason {
            manager.afterCase()
            return .Failure(f)
        } catch let p as PendingReason {
            manager.afterCase()
            return .Pending(p)
        } catch {
            return .Failure(.Unexpected)
        }
    }
}
