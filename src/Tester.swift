public class Tester {
    private var testUnits: [TestUnit] = []

    public init() {}

    public func register(testUnit: TestUnit) {
        testUnits.append(testUnit)
    }

    public func run(reporter: TestReporter) {
        reporter.testStarting(testUnits)
        for testUnit in testUnits {
            reporter.testUnitStarting(testUnit)
            runTestUnit(reporter, testUnit: testUnit)
            reporter.testUnitFinished(testUnit)
        }
        reporter.testFinished(testUnits)
    }

    private func runTestUnit(reporter: TestReporter, testUnit: TestUnit) {
        testUnit.setUp()
        for testCase in testUnit.testCases {
            switch testCase.run() {
            case .Success:
                reporter.testCaseSucceeded(testCase)
            case let .Failure(fr):
                reporter.testCaseFailed(testCase, reason: fr.stringify())
            case let .Pending(pr):
                reporter.testCasePending(testCase, reason: pr.stringify())
            }
        }
        testUnit.tearDown()
    }
}
