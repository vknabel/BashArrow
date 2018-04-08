import XCTest
import ArrowKit
import Foundation
@testable import BashArrowKit

func archerfile(_ contents: [String: Any]) throws -> Archerfile {
    let stringified = try JSONSerialization.data(withJSONObject: contents)
    return try JSONDecoder().decode(Archerfile.self, from: stringified)
}

extension XCTestCase {
    func fireSnapshot(
        _ command: String,
        _ arguments: String...,
        printCommandBeforeExecution: Bool = false,
        workingDirectory: String? = nil,
        archerfile archerfileContents: [String: Any] = [:],
        test: String = #function
    ) {
        let testName = "[" + String(describing: type(of: self)) + " " + test.dropLast(2) + "]"
        let snapshotsDir = FileManager.default.currentDirectoryPath
            + "/Tests/BashArrowTests/snapshots"
        let pinnedSnapshotPath = "\(snapshotsDir)/\(testName).xcsnapshot"
        let currentSnapshotPath = "\(snapshotsDir)/\(testName).xcsnapshot.out"
        let bash = BashArrow(
            arrow: "BashArrow",
            help: nil,
            command: "echo $(\(command)) > '\(currentSnapshotPath)'",
            printCommandBeforeExecution: printCommandBeforeExecution,
            workingDirectory: workingDirectory
        )
        try! FileManager.default.createDirectory(
            atPath: snapshotsDir,
            withIntermediateDirectories: true
        )
        XCTAssertNoThrow(try bash.fire(
            archerfile: archerfile(archerfileContents),
            arguments: arguments
        ))

        do {
            let currentSnapshot = try String(contentsOfFile: currentSnapshotPath)
            let pinnedSnapshot = try? String(contentsOfFile: pinnedSnapshotPath)
            if let pinnedSnapshot = pinnedSnapshot {
                XCTAssertEqual(currentSnapshot, pinnedSnapshot, "Snapshot mismatch")
            } else {
                try currentSnapshot.write(
                    toFile: pinnedSnapshotPath,
                    atomically: true,
                    encoding: .utf8
                )
                print("Pinned \u{001B}[36m\(testName)\u{001B}[0m to\n\u{001B}[33m\(currentSnapshot)\u{001B}[0m")
                XCTAssertEqual(currentSnapshot, currentSnapshot)
            }
        } catch {
            XCTAssertNoThrow(try { throw error }())
        }
    }

}