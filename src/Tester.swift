public class Tester {
    private var testUnits: [TestUnit] = []

    public init() {}

    public func register(testUnit: TestUnit) {
        testUnits.append(testUnit)
    }

    public func run(reporter: TestReporter) {
        for testUnit in testUnits {
            reporter.testUnitStarting(testUnit.description)
            runTestUnit(reporter, testUnit: testUnit)
            reporter.testUnitFinished(testUnit.description)
        }
    }

    private func runTestUnit(reporter: TestReporter, testUnit: TestUnit) {
        for testCase in testUnit.testCases {
            switch testCase.run() {
            case .Success:
                reporter.testCaseSucceeded(testCase.description)
            case let .Failure(place):
                reporter.testCaseFailed(testCase.description, place: place)
            }
        }
    }
}

public protocol TestReporter {
    func testUnitStarting(description: String)
    func testUnitFinished(description: String)
    func testCaseSucceeded(description: String)
    func testCaseFailed(description: String, place: FailurePlace)
}
