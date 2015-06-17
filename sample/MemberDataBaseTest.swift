import PureSwiftUnit

class MemberDataBaseTest : TestUnit {
    init() {
        super.init("MemberDataBase class")
        setTestCases([
            ("can add member via addMember method", canAddMember),
            ("can remove member via removeMember method", canRemoveMember),
            ("can clear all member via clearAll method", canClearAll)
        ])
    }

    var db: MemberDataBase!

    override func beforeCase() {
        db = MemberDataBase()
    }

    private func canAddMember() -> TestResult {
        let id = db.addMember("John Lennon")
        guard db.memberCount() == 1 else {
            return TestResult.buildFailure(
                "member count", expected: 1, actual: db.memberCount()
            )
        }
        guard db.nextId() == id + 1 else {
            return TestResult.buildFailure(
                "next id", expected: id + 1, actual: db.nextId()
            )
        }
        return .Success
    }

    private func canRemoveMember() -> TestResult {
        let id = db.addMember("John Lennon")
        let result = db.removeMember(id)
        guard result else {
            return TestResult.buildFailure(
                "result of removeMember", expected: "true", actual: "false"
            )
        }
        guard db.memberCount() == 0 else {
            return TestResult.buildFailure(
                "member count", expected: 0, actual: db.memberCount()
            )
        }
        guard db.nextId() == id + 1 else {
            return TestResult.buildFailure(
                "next id", expected: id + 1, actual: db.nextId()
            )
        }
        return .Success
    }

    private func canClearAll() -> TestResult {
        return .Pending("\"clearAll\" method is removed now.")
    }
}
