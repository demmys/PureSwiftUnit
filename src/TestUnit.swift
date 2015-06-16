public protocol TestUnit {
    var description: String { get }
    var testCases: [TestCase] { get }
    func setUp()
    func beforeCase()
    func afterCase()
    func tearDown()
}

public enum TestResult {
    case Success
    case Failure(String)
    case Pending(String)

    public static func buildFailure(parameter: String,
                                    expected: String,
                                    actual: String) -> TestResult {
        return .Failure("expected \(parameter) to \(expected) but actual is \(actual).")
    }
    public static func buildFailure(parameter: String,
                                    expected: Int,
                                    actual: Int) -> TestResult {
        return TestResult.buildFailure(parameter,
                                       expected: String(expected),
                                       actual: String(actual))
    }
}

public class TestCase {
    private let manager: TestUnit
    private let test: () -> TestResult
    public let description: String

    public init(_ manager: TestUnit, test: () -> TestResult, description: String) {
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
