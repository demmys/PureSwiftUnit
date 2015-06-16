public class MemberDataBase {
    private var members: [Int:String] = [:]
    private var id: Int = 0

    public init() {}

    public func addMember(member: String) -> Int {
        members[id++] = member
        return id - 1
    }

    public func removeMember(id: Int) -> Bool {
        return members.removeValueForKey(id) != nil
    }

    public func memberCount() -> Int {
        return members.count
    }

    func nextId() -> Int {
        return id
    }
}
