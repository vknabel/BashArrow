import ArrowKit
import Foundation

public struct BashArrow: Arrow {
    public let arrow: String
    public let help: String?
    public let command: String
    public let printCommandBeforeExecution: Bool?
    public let workingDirectory: String?

    public func fire(archerfile _: Archerfile, arguments: [String]) throws {
        let launchPath = "/usr/bin/env"
        let process = Process()
        process.launchPath = launchPath
        process.currentDirectoryPath = targetWorkingDirectory
        let commandWithEscapedArguments = "\u{001B}[36m" + command + "\u{001B}[0m" + " with arguments " + "\u{001B}[96m" + escaped(arguments) + "\u{001B}[0m"
        if printCommandBeforeExecution ?? false {
            print("🏹  \(workingDirectoryHint) $ \(commandWithEscapedArguments)")
        }
        process.arguments = ["bash", "-c", command, targetWorkingDirectory] + arguments
        process.launch()
        process.waitUntilExit()
        if process.terminationStatus != 0 {
            if !(printCommandBeforeExecution ?? false) {
                print("🏹  \(workingDirectoryHint) $ \(commandWithEscapedArguments)")
            }
            throw NSError(domain: "BashArrow", code: Int(process.terminationStatus))
        }
    }

    func escaped(_ arguments: [String]) -> String {
        func escaping(_ char: String) -> (String) -> String {
            return { $0.replacingOccurrences(of: char, with: "\\" + char) }
        }
        return arguments.map(escaping("\\"))
            .map(escaping("\""))
            .map(escaping("`"))
            .map(escaping("$"))
            .map(escaping("!"))
            .map { "\"\($0)\"" }
            .joined(separator: " ")
    }

    var targetWorkingDirectory: String {
        return workingDirectory ?? FileManager.default.currentDirectoryPath
    }

    var workingDirectoryHint: String {
        return targetWorkingDirectory.split(separator: "/").last.map(String.init) ?? targetWorkingDirectory
    }
}
