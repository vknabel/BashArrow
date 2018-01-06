import Foundation
import ArrowKit

struct BashArrow: Arrow {
    let arrow: String
    let command: String
    let printCommandBeforeExecution = false
    let help: String?
    let workingDirectory = {
        FileManager
            .defaultManager
            .currentDirectoryPath
    }()

    func fire(archerfile: Archerfile, arguments: [String]) throws {
        let launchPath = "/usr/bin/env"
        let process = Process()
        process.launchPath = launchPath
        process.currentDirectoryPath = workingDirectory
        let commandWithEscapedArguments = command + " " + escaped(arguments)
        if printCommandBeforeExecution {
            print("🏹 \(workingDirectoryHint) $ \(commandWithEscapedArguments)")
        }
        process.arguments = ["bash", "-c", command + " " + escaped(arguments)]
        process.launch()
        process.waitUntilExit()
        if process.terminationStatus != 0 {
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

    var workingDirectoryHint: String {
        return workingDirectory.split(separator: "/").last.map(String.init) ?? workingDirectory
    }
}

BashArrow.fire()
