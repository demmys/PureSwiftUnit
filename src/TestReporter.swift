public protocol TestReporter {
    func testStarting(testUnits: [TestUnit])
    func testFinished(testUnits: [TestUnit])
    func testUnitStarting(testUnit: TestUnit)
    func testUnitFinished(testUnit: TestUnit)
    func testCaseSucceeded(testCase: TestCase)
    func testCaseFailed(testCase: TestCase, reason: String)
    func testCasePending(testCase: TestCase, reason: String)
}

public class DefaultTestReporter : TestReporter {
    var currentUnit: TestUnit!
    var successes: Int = 0
    var failures: [String] = []
    var pendings: [String] = []

    public init() {}

    public func testStarting(testUnits: [TestUnit]) {
        print("Testing \(testUnits.count) units...\n")
    }

    public func testFinished(testUnits: [TestUnit]) {
        print("\nAll test finished.")
        if pendings.count > 0 {
            print("\nPending cases:")
            for pending in pendings {
                print("\t\(pending)")
            }
        }
        if failures.count > 0 {
            print("\nFailed cases:")
            for failure in failures {
                print("\t\(failure)")
            }
        }
        print("\nSuccess: \(successes) cases, Failure: \(failures.count) cases, Pending: \(pendings.count) cases")
    }

    public func testUnitStarting(testUnit: TestUnit) {
        currentUnit = testUnit
    }

    public func testUnitFinished(testUnit: TestUnit) {}

    public func testCaseSucceeded(testCase: TestCase) {
        print("[SUCCEEDED]\t\(currentUnit.description) \(testCase.description)")
        ++successes
    }

    public func testCaseFailed(testCase: TestCase, reason: String) {
        let message = "\(currentUnit.description) \(testCase.description)\n\t\t- \(reason)"
        print("[FAILED]\t\(message)")
        failures.append(message)
    }

    public func testCasePending(testCase: TestCase, reason: String) {
        let message = "\(currentUnit.description) \(testCase.description)\n\t\t- \(reason)"
        print("[PENDING]\t\(message)")
        pendings.append(message)
    }
}
