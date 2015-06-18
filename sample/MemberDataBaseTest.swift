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

    private func canAddMember() throws {
        let id = db.addMember("John Lennon")
        try equals("member count", db.memberCount(), 1)
        try equals("next id", db.nextId(), id + 1)
    }

    private func canRemoveMember() throws {
        let id = db.addMember("John Lennon")
        let result = db.removeMember(id)
        try isTrue("result of removeMember", result)
        try equals("member count", db.memberCount(), 0)
        try equals("next id", db.nextId(), id + 1)
    }

    private func canClearAll() throws {
        throw PendingReason.Text("\"clearAll\" method is removed now.")
    }
}
