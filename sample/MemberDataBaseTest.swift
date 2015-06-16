import PureSwiftUnit

class MemberDataBaseTest : TestUnit {
    var description: String { get { return "MemberDataBase class" } }

    var testCases: [TestCase] { get { return [
        TestCase(self,
                 test: canAddMember,
                 description: "can add member via addMember method"),
        TestCase(self,
                 test: canRemoveMember,
                 description: "can remove member via removeMember method"),
        TestCase(self,
                 test: canClearAll,
                 description: "can clear all member via clearAll method")
    ] } }

    var db: MemberDataBase!

    func setUp() {}

    func beforeCase() {
        db = MemberDataBase()
    }

    func afterCase() {}

    func tearDown() {}

    private func canAddMember() -> TestResult {
        let id = db.addMember("John Lennon")
        guard db.memberCount() == 1 else {
            return TestResult.buildFailure("member count",
                                           expected: 1,
                                           actual: db.memberCount())
        }
        guard db.nextId() == id + 1 else {
            return TestResult.buildFailure("next id",
                                           expected: id + 1,
                                           actual: db.nextId())
        }
        return .Success
    }

    private func canRemoveMember() -> TestResult {
        let id = db.addMember("John Lennon")
        let result = db.removeMember(id)
        guard result else {
            return TestResult.buildFailure("result of removeMember",
                                           expected: "true",
                                           actual: "false")
        }
        guard db.memberCount() == 0 else {
            return TestResult.buildFailure("member count",
                                           expected: 0,
                                           actual: db.memberCount())
        }
        guard db.nextId() == id + 1 else {
            return TestResult.buildFailure("next id",
                                           expected: id + 1,
                                           actual: db.nextId())
        }
        return .Success
    }

    private func canClearAll() -> TestResult {
        return .Pending("\"clearAll\" method is removed now.")
    }
}
