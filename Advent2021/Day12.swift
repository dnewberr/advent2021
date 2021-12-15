import Foundation

final class Day12: Solution {
    let testInput: String = """
     start-A
     start-b
     A-c
     A-b
     b-d
     A-end
     b-end
     """
    
    let testInput2: String = """
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
    """
    
    let testInput3: String = """
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
    """
    
    let fullInput: String = """
     QF-bw
     end-ne
     po-ju
     QF-lo
     po-start
     XL-ne
     bw-US
     ne-lo
     nu-ne
     bw-po
     QF-ne
     ne-ju
     start-lo
     lo-XL
     QF-ju
     end-ju
     XL-end
     bw-ju
     nu-start
     lo-nu
     nu-XL
     xb-XL
     XL-po
     """
    
    var nameToNode = [String: Node]()

    func pt1(_ input: String) -> Int {
        nameToNode = [String: Node]()
        
        let connections = input.components(separatedBy: "\n")
        parse(connections)
        let graph = Graph(nodes: Array(nameToNode.values))
        graph.findAllPaths(start: nameToNode["start"]!, destination: nameToNode["end"]!)
        
        return graph.allPaths.count
    }
    
    func pt2(_ input: String) -> Int {
        nameToNode = [String: Node]()
        
        let connections = input.components(separatedBy: "\n")
        parse(connections)
        let graph = Graph(nodes: Array(nameToNode.values), allowsMultVisits: true)
        graph.findAllPaths(start: nameToNode["start"]!, destination: nameToNode["end"]!)
        
        return graph.allPaths.count
    }
    
    func parse(_ connections: [String]) {
        for connection in connections {
            let splits = connection.matches("(\\w+)-(\\w+)").flatMap { $0 }
            guard !splits.isEmpty else { continue }
            let name = splits[1]
            let firstNode = nameToNode[name, default: Node(name: name)]
            
            let connectionName = splits[2]
            let secondNode = nameToNode[connectionName, default: Node(name: connectionName)]
            
            secondNode.connections.append(firstNode)
            firstNode.connections.append(secondNode)
            
            nameToNode[name] = firstNode
            nameToNode[connectionName] = secondNode
        }
    }
}

class Graph {
    let nodes: [Node]
    let allowsMultVisits: Bool
    var allPaths = Set<[Node]>()
    
    init(nodes: [Node], allowsMultVisits: Bool = false) {
        self.nodes = nodes
        self.allowsMultVisits = allowsMultVisits
    }

    func findAllPaths(start: Node, destination: Node) {
        findAllPathsUtil(start: start, destination: destination, pathList: [start], hasVisitedSmallCaveTwice: false)
    }
    
    private func findAllPathsUtil(start: Node, destination: Node, pathList: [Node], hasVisitedSmallCaveTwice: Bool) {
        if start == destination {
            allPaths.insert(pathList)
            return
        }
        
        start.numTimesVisited += 1
        
        var hasVisitedSmallCaveTwice = hasVisitedSmallCaveTwice
        if start.isSmall && start.numTimesVisited == 2 {
            hasVisitedSmallCaveTwice = true
        }

        for node in start.connections {
            guard canVisit(node, hasVisitedSmallCaveTwice: hasVisitedSmallCaveTwice) else { continue }
            findAllPathsUtil(start: node, destination: destination, pathList: pathList + [node], hasVisitedSmallCaveTwice: hasVisitedSmallCaveTwice)
        }
        
        start.numTimesVisited -= 1
    }
    
    private func canVisit(_ node: Node, hasVisitedSmallCaveTwice: Bool) -> Bool {
        if node.name == "start" || node.name == "end" {
            return node.numTimesVisited == 0
        }
        
        if node.isSmall {
            let upperBound = allowsMultVisits && !hasVisitedSmallCaveTwice
                ? 2
                : 1
            return node.numTimesVisited < upperBound
        }
        
        return true
    }
}

class Node: Equatable, Hashable {
    let name: String
    var connections: [Node]
    var numTimesVisited = 0
    
    init(name: String, connections: [Node] = []) {
        self.name = name
        self.connections = connections
    }
    
    var debug: String {
        return "\(name) -> \(connections.map { $0.name }.joined(separator: ", "))"
    }
    
    var isSmall: Bool {
        let unicode = name.unicodeScalars
        let isLower = unicode.filter { !NSCharacterSet.lowercaseLetters.contains($0) }.isEmpty
        return isLower
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool { lhs.name == rhs.name && lhs.numTimesVisited == rhs.numTimesVisited }
    func hash(into hasher: inout Hasher) { hasher.combine(name) }
}
