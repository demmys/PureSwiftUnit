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

    public func setTestCases(tests: [(String, () -> TestResult)]) {
        self.testCases = []
        for (d, t) in tests {
            self.testCases.append(TestCase(manager: self, test: t, description: d))
        }
    }
}

public enum TestResult {
    case Success
    case Failure(String)
    case Pending(String)

    public static func buildFailure(
        parameter: String, expected: String, actual: String
    ) -> TestResult {
        return .Failure(
            "expected \(parameter) to \(expected) but actual is \(actual)."
        )
    }
    public static func buildFailure(
        parameter: String, expected: Int, actual: Int
    ) -> TestResult {
        return TestResult.buildFailure(
            parameter, expected: String(expected), actual: String(actual)
        )
    }
}

public class TestCase {
    private let manager: TestUnit
    private let test: () -> TestResult
    public let description: String

    public init(manager: TestUnit, test: () -> TestResult, description: String) {
        self.manager = manager
        self.test = test
        self.description = description
    }

    internal func run() -> TestResult {
        manager.beforeCase()
        let result = test()
        manager.afterCase()
        return result
    }
}
