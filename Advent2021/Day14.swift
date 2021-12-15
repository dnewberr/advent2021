import Darwin
final class Day14: Solution {
    let testInput: String = """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """
    
    let fullInput: String = """
    OHFNNCKCVOBHSSHONBNF

    SV -> O
    KP -> H
    FP -> B
    VP -> V
    KN -> S
    KS -> O
    SB -> K
    BS -> K
    OF -> O
    ON -> S
    VS -> F
    CK -> C
    FB -> K
    CH -> K
    HS -> H
    PO -> F
    NP -> N
    FH -> C
    FO -> O
    FF -> C
    CO -> K
    NB -> V
    PP -> S
    BB -> N
    HH -> B
    KK -> H
    OP -> K
    OS -> V
    KV -> F
    VH -> F
    OB -> S
    CN -> H
    SF -> K
    SN -> P
    NF -> H
    HB -> V
    VC -> S
    PS -> P
    NK -> B
    CV -> P
    BC -> S
    NH -> K
    FN -> P
    SH -> F
    FK -> P
    CS -> O
    VV -> H
    OC -> F
    CC -> N
    HK -> N
    FS -> P
    VF -> B
    SS -> V
    PV -> V
    BF -> V
    OV -> C
    HO -> F
    NC -> F
    BN -> F
    HC -> N
    KO -> P
    KH -> F
    BV -> S
    SK -> F
    SC -> F
    VN -> V
    VB -> V
    BH -> O
    CP -> K
    PK -> K
    PB -> K
    FV -> S
    HN -> K
    PH -> B
    VK -> B
    PC -> H
    BO -> H
    SP -> V
    NS -> B
    OH -> N
    KC -> H
    HV -> F
    HF -> B
    HP -> S
    CB -> P
    PN -> S
    BK -> K
    PF -> N
    SO -> P
    CF -> B
    VO -> C
    OO -> K
    FC -> F
    NV -> F
    OK -> K
    NN -> O
    NO -> O
    BP -> O
    KB -> O
    KF -> O
    """
    
    func pt1(_ input: String) -> Int {
        let inputArray = input.components(separatedBy: "\n")
        parse(inputArray)
        applyInsertion(numTimes: 10)
        return getMaxMinCharCountDiff()
    }
    
    func pt2(_ input: String) -> Int {
        let inputArray = input.components(separatedBy: "\n")
        parse(inputArray)
        applyInsertion(numTimes: 40)
        return getMaxMinCharCountDiff()
    }
    
    var polymerTemplate = ""
    var insertionRules = [String : String]()
    var polymerCounts = [String: Int]()
    var pairCount = [String: Int]()
    
    func parse(_ inputArray: [String]) {
        insertionRules.removeAll()
        polymerTemplate = ""
        polymerCounts.removeAll()
        pairCount.removeAll()
        
        guard inputArray.count >= 2 else { return }
        
        if let template = inputArray.first {
            polymerTemplate = template
            let letters = Array(template)
            for i in 0..<(letters.count - 1) {
                pairCount["\(String(letters[i]))\(String(letters[i + 1]))", default: 0] += 1
                polymerCounts[String(letters[i]), default: 0] += 1
            }
            polymerCounts[String(letters.last!), default: 0] += 1
        }
        
        for i in 2..<inputArray.count {
            let currentReplacement = inputArray[i].components(separatedBy: " -> ")
            guard currentReplacement.count == 2 else { continue }
            insertionRules[currentReplacement[0]] = currentReplacement[1]
        }
    }
    
    func applyInsertion(numTimes: Int) {
        print(polymerCounts)
        for i in 0..<numTimes {
            print("ROUND \(i)")
            insertionRound()
        }
    }
    
    func getMaxMinCharCountDiff() -> Int {
        return abs((polymerCounts.values.max() ?? 0) - (polymerCounts.values.min() ?? 0))
    }

    /*
    func insertionRound() {
        var newTemplate = Array(polymerTemplate)
        let allCharsInTemplate = Array(polymerTemplate)
        var newTemplateIndex = 1
        
        guard allCharsInTemplate.count >= 2 else { return }
        for i in 0..<allCharsInTemplate.count - 1 {
            let currentCharacter = String(allCharsInTemplate[i])
            let nextCharacter = String(allCharsInTemplate[i + 1])
            let duo = currentCharacter + nextCharacter
            if let insertion = insertionRules[duo] {
                newTemplate.insert(contentsOf: insertion, at: newTemplateIndex)
                polymerCounts[insertion, default: 0] += 1
                newTemplateIndex += 1
            }
            newTemplateIndex += 1
        }
        polymerTemplate = newTemplate.map { String($0) }.joined()
    }
     */
    
    func insertionRound() {
        var newPairCount = [String: Int]()
        
//        print(pairCount)
        
        for (pair, count) in pairCount {
            let polymer = insertionRules[pair]!
            polymerCounts[polymer, default: 0] += count
            newPairCount[String(pair.first!) + polymer, default: 0] += count
            newPairCount[polymer + String(pair.last!), default: 0] += count
        }
        
        print(polymerCounts)
        self.pairCount = newPairCount
//        print(pairCount)
    }
}
