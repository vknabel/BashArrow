import XCTest

class BashArrowTests: XCTestCase {
    func testEmptyCommandWillNotCrash() {
        fireSnapshot("")
    }

    func testParameterWillNotBeAppended() {
        fireSnapshot("echo", "Hidden")
    }

    func testParametersWillBePassedAsArgument() {
        fireSnapshot("echo $@", "Printed")
    }

    func testParametersCanAccessParametersByNumber() {
        fireSnapshot("echo $2", "Hidden", "Should print second one")
    }
}
