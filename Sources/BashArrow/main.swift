import Foundation
import ArrowKit

struct BashArrow: Arrow {
    let arrow: String
    let help: String?
    let command: String
    let printCommandBeforeExecution: Bool?
    let workingDirectory: String?

    func fire(archerfile: Archerfile, arguments: [String]) throws {
        let launchPath = "/usr/bin/env"
        let process = Process()
        process.launchPath = launchPath
        process.currentDirectoryPath = targetWorkingDirectory
        let commandWithEscapedArguments = command + " " + escaped(arguments)
        if printCommandBeforeExecution ?? false {
            print("🏹  \(workingDirectoryHint) $ \(commandWithEscapedArguments)")
        }
        process.arguments = ["bash", "-c", command + " " + escaped(arguments)]
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

BashArrow.fire()
