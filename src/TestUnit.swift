public protocol TestUnit {
    var description: String { get }
    var testCases: [TestCase] { get }
    func setUp()
    func tearDown()
}

public enum TestResult {
    case Success
    case Failure(FailurePlace)
}

public struct FailurePlace {
    public let file: String
    public let function: String

    public init(_ file: String, _ function: String) {
        self.file = file
        self.function = function
    }

    public func stringify() -> String {
        return "\(file):\(function)"
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
        manager.setUp()
        let result = test()
        manager.tearDown()
        return result
    }
}
