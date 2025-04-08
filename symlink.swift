#!/usr/bin/env swift

import Foundation

let DATA_DIR = "data"
let LINK_TXT = "link.txt"

let fm = FileManager.default
let home = NSHomeDirectory()
let currentDir = URL.currentDirectory()
let dataDir = currentDir.relativePath + "/" + DATA_DIR

struct Executor {
    var linkAccessor: [String: Bool]

    init(linkAccessor: [String: Bool]) {
        self.linkAccessor = linkAccessor
    }

    func exec(path: URL) {
        let urls = loadDir(path)
        for url in urls {
            let last = url.lastPathComponent

            if self.linkAccessor[last] ?? false {
                self.recreateSymbolicLinkFrom(url: url)
                continue
            }

            if url.hasDirectoryPath {
                exec(path: url)
            }
        }
    }

    private func recreateSymbolicLinkFrom(url: URL) {
        let source = url.relativePath

        let to =
            source
            .replacingOccurrences(of: dataDir, with: home)
            .replacingOccurrences(of: ".jsonc", with: ".json")

        try? fm.removeItem(atPath: to)

        try! fm.createSymbolicLink(atPath: to, withDestinationPath: source)
    }

    private func loadDir(_ dir: URL) -> [URL] {
        return try! fm.contentsOfDirectory(
            at: dir, includingPropertiesForKeys: nil)
    }

}

func loadLinks() -> [String: Bool] {
    let linkFile = URL(fileURLWithPath: LINK_TXT)
    let linkData = try! Data(contentsOf: linkFile)
    let linkString = String(data: linkData, encoding: .utf8)!

    return
        linkString
        .components(separatedBy: "\n")
        .reduce(into: [:]) { acc, cur in
            if !cur.isEmpty {
                acc[cur] = true
            }
        }
}

func main() {
    let accessor = loadLinks()
    let executor = Executor(linkAccessor: accessor)
    let entry = URL(fileURLWithPath: DATA_DIR)
    executor.exec(path: entry)
}

main()
