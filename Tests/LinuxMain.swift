// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import BashArrowKitTests
import XCTest

extension BashArrowTests {
    static var allTests: [(String, (BashArrowTests) -> () throws -> Void)] = [
        ("testEmptyCommandWillNotCrash", testEmptyCommandWillNotCrash),
        ("testParameterWillNotBeAppended", testParameterWillNotBeAppended),
        ("testParametersWillBePassedAsArgument", testParametersWillBePassedAsArgument),
        ("testParametersCanAccessParametersByNumber", testParametersCanAccessParametersByNumber),
    ]
}

// swiftlint:disable trailing_comma
XCTMain([
    testCase(BashArrowTests.allTests),
])
// swiftlint:enable trailing_comma
