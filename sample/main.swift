import PureSwiftUnit

let tester = Tester()
tester.register(MemberDataBaseTest())
tester.run(DefaultTestReporter())
