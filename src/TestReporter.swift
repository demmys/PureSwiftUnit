public protocol TestReporter {
    func testUnitStarting(description: String)
    func testUnitFinished(description: String)
    func testCaseSucceeded(description: String)
    func testCaseFailed(description: String, place: FailurePlace)
}

public class StdoutTestReporter : TestReporter {
    public init() {}

    public func testUnitStarting(description: String) {
        print("TestUnit Start: \(description)")
    }

    public func testUnitFinished(description: String) {
        print("TestUnit Finish: \(description)")
    }

    public func testCaseSucceeded(description: String) {
        print("[\(description)] SUCCEEDED")
    }

    public func testCaseFailed(description: String, place: FailurePlace) {
        print("[\(description)] FAILED (\(place.stringify()))")
    }
}
