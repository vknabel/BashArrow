import ArrowKit
import Foundation

/// Runs bash scripts out of your Archerfile.
public struct BashArrow: Arrow {
    /// The name of the arrow
    /// :nodoc:
    public let arrow: String
    /// Hint used for the help command.
    public let help: String?
    /// The bash command to be executed.
    /// Arguments can be accessed using `$@` or `$1`.
    public let command: String
    /// Indicates wether the command shall be printed before execution.
    public let printCommandBeforeExecution: Bool?
    /// The working directory for the command to be executed in.
    public let workingDirectory: String?

    /// Run the bash arrow against given arguments and a given archerfile.
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
