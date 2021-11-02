// Python docs: https://docs.python.org/2/library/stdtypes.html
//
// Most frequently used:
//   15 file.close
//    9 file.name
//    8 file.readline
//    7 file.write
//    2 file.read
//    1 file.writelines
//    1 file.readlines
//    1 file.fileno
//
// >>> filter(lambda s: not s.startswith("_"), dir(open("/tmp/foo")))
//   close: TODO.
//   closed
//   encoding
//   errors
//   fileno
//   flush: TODO.
//   isatty
//   mode
//   name
//   newlines
//   next
//   read
//   readinto
//   readline
//   readlines
//   seek
//   softspace
//   tell
//   truncate
//   write: TODO.
//   writelines
//   xreadlines

import Foundation

public typealias file = FileHandle

public extension FileHandle {
    func read() -> String {
        let data: Data = self.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)!
    }

    func readLines() -> [String] {
        return self.read().strip().split("\n")
    }

    func readlines() -> [String] {
        return self.readLines()
    }

    func close() {
        self.closeFile()
    }

    func write(s: String) {
        if let data = s.data(using: .utf8) {
            self.write(data)
        }
    }
}
