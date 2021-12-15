import os

fileprivate extension Array where Element : Collection, Element.Index == Int {
    func isValidIndex(_ curIndex: Day11.Index) -> Bool {
        curIndex.row < self.count && curIndex.row >= 0
            && curIndex.col < self[curIndex.row].count && curIndex.col >= 0
    }
}

final class Day11 {
    struct Index: Equatable {
        let row: Int
        let col: Int
        
        var debug: String {
            return "[\(row), \(col)]"
        }
    }
    
    var numFlashes = 0
    var energyGrid = [[String]]()
    
    var isAllFlashing: Bool {
        energyGrid.filter { rowString in
            rowString != Array(repeating: "0", count: rowString.count)
        }.isEmpty
    }
    
    let fullInput = """
    7232374314
    8531113786
    3411787828
    5482241344
    5856827742
    7614532764
    5311321758
    1255116187
    5821277714
    2623834788
    """
    
    let testInput = """
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    """
    
    let testInput2 = """
    11111
    19991
    19191
    19991
    11111
    """
    
    func run() {
        pt1(fullInput)
        pt2(fullInput)
    }
    
    private func pt1(_ input: String) {
        energyGrid = input.components(separatedBy: "\n").map { Array($0).map { String($0) }}
        
        (0..<100).forEach { step in
            // 1 - increment
            incrementAll()
            // 2 - flash & repeat for 100 steps
            numFlashes += flash().count
        }
        
        print("pt 1 - \(numFlashes)")
    }
    
    private func pt2(_ input: String) {
        energyGrid = input.components(separatedBy: "\n").map { Array($0).map { String($0) }}
        
        var step = 0
        while !isAllFlashing {
            step += 1
            // 1 - increment
            incrementAll()
            // 2 - flash & repeat
            numFlashes += flash().count
        }
        
        print("pt 2 - \(step)")
    }
    
    private func incrementAll() {
        energyGrid = energyGrid.map { $0.map { val in String(Int(val)! + 1) } }
    }
    
    private func shouldFlash(_ val: Int) -> Bool {
        val >= 10
    }
    
    private func flash(indecesFlashed: [Index] = [Index]()) -> ([Index]) {
        var indecesFlashed = indecesFlashed
        var didFlash = false
        
        for i in 0..<energyGrid.count {
            for j in 0..<energyGrid[i].count {
                guard let curVal = Int(energyGrid[i][j]) else {continue}
                let index = Index(row: i, col: j)
                if shouldFlash(curVal) && !indecesFlashed.contains(index) {
                    energyGrid[i][j] = "0"
                    incrementNeighbors(index: index, indecesFlashed: indecesFlashed)
                    indecesFlashed.append(index)
                    didFlash = true
                }
            }
        }
        
        if didFlash {
            return flash(indecesFlashed: indecesFlashed)
        }
        
        return indecesFlashed
    }
    
    private func incrementNeighbors(index: Index, indecesFlashed: [Index]) {
        let i = index.row
        let j = index.col
        
        [Index(row: i - 1, col: j - 1),
         Index(row: i + 1, col: j - 1),
         Index(row: i - 1, col: j + 1),
         Index(row: i + 1, col: j + 1),
         Index(row: i - 1, col: j),
         Index(row: i + 1, col: j),
         Index(row: i, col: j - 1),
         Index(row: i, col: j + 1)].forEach { index in
            if canIncrement(index: index, indecesFlashed: indecesFlashed) {
                let val = Int(energyGrid[index.row][index.col])!
                energyGrid[index.row][index.col] = "\(val + 1)"
            }
        }
    }
    
    private func canIncrement(index: Index, indecesFlashed: [Index]) -> Bool {
        energyGrid.isValidIndex(index) && !indecesFlashed.contains(index)
    }
}
