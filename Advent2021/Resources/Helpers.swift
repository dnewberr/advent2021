import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}


extension String {
    func matches(_ regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).compactMap {
                let resultRange = result.range(at: $0)
                guard resultRange.location != NSNotFound else { return nil }
                return nsString.substring(with: resultRange)
            }
        }
    }
}

extension Array {
    var middle: Element? {
        guard count != 0 else { return nil }

        let middleIndex = (count > 1 ? count - 1 : count) / 2
        return self[middleIndex]
    }
}

protocol Solution: AnyObject {
    var testInput: String { get }
    var fullInput: String { get }
    func run()
    func pt1(_ input: String) -> Int
    func pt2(_ input: String) -> Int
}
extension Solution {
    func run() {
        print("\n***************")
        print("Running \(String(describing: self))...")
        print("\t [Test Input] Part 1 answer - \(pt1(testInput))")
        print("\t [Full Input] Part 1 answer - \(pt1(fullInput))")
        print("***")
        print("\t [Test Input] Part 2 answer - \(pt2(testInput))")
        print("\t [Full Input] Part 2 answer - \(pt2(fullInput))")
        print("***************\n")
    }
}

struct GridIndex: Hashable {
    let row: Int
    let column: Int
    
    var debug: String {
        "[\(row)][\(column)]"
    }
    
    static subscript(_ row: Int, _ column: Int) -> GridIndex {
        return GridIndex(row: row, column: column)
    }
    
    func adjacentIndeces(includingDiagonals addDiagonals: Bool) -> [GridIndex] {
        var indeces = [
            GridIndex(row: row, column: column + 1),
            GridIndex(row: row, column: column - 1),
            GridIndex(row: row - 1, column: column),
            GridIndex(row: row + 1, column: column)
        ]
        
        if addDiagonals {
            indeces += [
                GridIndex(row: row - 1, column: column - 1),
                GridIndex(row: row + 1, column: column + 1),
                GridIndex(row: row - 1, column: column + 1),
                GridIndex(row: row + 1, column: column - 1)
            ]
        }
        
        return indeces
        
    }
}

extension Array where Element: Collection, Element.Index == Int {
    func isValidIndex(_ curIndex: GridIndex) -> Bool {
        curIndex.row < self.count && curIndex.row >= 0
        && curIndex.column < self[curIndex.row].count && curIndex.column >= 0
    }
    
    subscript(index: GridIndex) -> Element.Element {
        self[index.row][index.column]
    }
    
    func prettyPrint() -> String {
        return self.map { row in
            row.map { "\($0)" }.joined()
        }.joined(separator: "\n")
    }
}
