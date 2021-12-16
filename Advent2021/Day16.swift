import Darwin
final class Day16: Solution {
    let testInput: String = """
     04005AC33890
    """
    // 620080001611562C8802118E34 = 12
    // C0015000016115A2E0802F182340 - 23
    // 8A004A801A8002F478 = 16
    // A0016C880162017C3686B18A3D4780 - 31
    
    let fullInput: String = """
    E0525D9802FA00B80021B13E2D4260004321DC648D729DD67B2412009966D76C0159ED274F6921402E9FD4AC1B0F652CD339D7B82240083C9A54E819802B369DC0082CF90CF9280081727DAF41E6A5C1B9B8E41A4F31A4EF67E2009834015986F9ABE41E7D6080213931CB004270DE5DD4C010E00D50401B8A708E3F80021F0BE0A43D9E460007E62ACEE7F9FB4491BC2260090A573A876B1BC4D679BA7A642401434937C911CD984910490CCFC27CC7EE686009CFC57EC0149CEFE4D135A0C200C0F401298BCF265377F79C279F540279ACCE5A820CB044B62299291C0198025401AA00021D1822BC5C100763A4698FB350E6184C00A9820200FAF00244998F67D59998F67D5A93ECB0D6E0164D709A47F5AEB6612D1B1AC788846008780252555097F51F263A1CA00C4D0946B92669EE47315060081206C96208B0B2610E7B389737F3E2006D66C1A1D4ABEC3E1003A3B0805D337C2F4FA5CD83CE7DA67A304E9BEEF32DCEF08A400020B1967FC2660084BC77BAC3F847B004E6CA26CA140095003900BAA3002140087003D40080022E8C00870039400E1002D400F10038C00D100218038F400B6100229500226699FEB9F9B098021A00800021507627C321006E24C5784B160C014A0054A64E64BB5459DE821803324093AEB3254600B4BF75C50D0046562F72B1793004667B6E78EFC0139FD534733409232D7742E402850803F1FA3143D00042226C4A8B800084C528FD1527E98D5EB45C6003FE7F7FCBA000A1E600FC5A8311F08010983F0BA0890021F1B61CC4620140EC010100762DC4C8720008641E89F0866259AF460C015D00564F71ED2935993A539C0F9AA6B0786008D80233514594F43CDD31F585005A25C3430047401194EA649E87E0CA801D320D2971C95CAA380393AF131F94F9E0499A775460
    """
    
    let mapping = [
        "0" : "0000",
        "1" : "0001",
        "2" : "0010",
        "3" : "0011",
        "4" : "0100",
        "5" : "0101",
        "6" : "0110",
        "7" : "0111",
        "8" : "1000",
        "9" : "1001",
        "A" : "1010",
        "B" : "1011",
        "C" : "1100",
        "D" : "1101",
        "E" : "1110",
        "F" : "1111"
    ]
    
    // 3 - packet version
    // 3 - packet type ID | 4 is literal | any other type is an operator; "focus on parsing the hierarchy of sub-packets."
        // this is called the length type ID:
            // 0 - 15 bits are a number that represents the total length in bits of the sub-packets contained by this packet.
            // 1 -  11 bits are a number that represents the number of sub-packets immediately contained by this packet.
            // after the 11 or 15, subpackets appear
    // 5  - start with 1, the rest are a num
    // 5 - start with 1, the rest are a num
    // 5 - start with 0 (end of grounp)  - num
    // everything after last group should be ignored
    // grups of 5 together make a number
    
    func pt1(_ input: String) -> Int {
        let binaryString = convertToBinary(input)
        let (rootPacket, _) = decodePacket(binaryString)
        return getVersionSum(rootPacket)
    }
    
    func pt2(_ input: String) -> Int {
        let binaryString = convertToBinary(input)
        let (rootPacket, _) = decodePacket(binaryString)
        return getValue(rootPacket)
    }
    
    func convertToBinary(_ input: String) -> String {
        let allChars = Array(input)
        var result = ""
        
        allChars.forEach {
            result += mapping[String($0), default: ""]
        }
        
        return result
    }
    
    func getValue(_ rootPacket: Packet) -> Int {
        switch rootPacket.typeId {
        case 0: return rootPacket.subpackets.map { getValue($0) }.reduce(0, +)
        case 1: return rootPacket.subpackets.map { getValue($0) }.reduce(1, *)
        case 2: return rootPacket.subpackets.map { getValue($0) }.min()!
        case 3: return rootPacket.subpackets.map { getValue($0) }.max()!
        case 4: return rootPacket.value
        case 5: return getValue(rootPacket.subpackets[0]) > getValue(rootPacket.subpackets[1]) ? 1 : 0
        case 6: return getValue(rootPacket.subpackets[0]) < getValue(rootPacket.subpackets[1]) ? 1 : 0
        case 7: return getValue(rootPacket.subpackets[0]) == getValue(rootPacket.subpackets[1]) ? 1 : 0
        default: return 0
        }
    }
    
    func getVersionSum(_ rootPacket: Packet) -> Int {
        return rootPacket.version + rootPacket.subpackets.map { getVersionSum($0) }.reduce(0, +)
    }
    
    func decodePacket(_ raw: String) -> (Packet, String) {
        let binaryStringArray = Array(raw).map { String($0) }
        let packet = Packet(version: binaryStringArray[0..<3].joined().binaryStringToInt(),
                            typeId: binaryStringArray[3..<6].joined().binaryStringToInt())
        if packet.typeId == 4 {
            let (value, remainder) = decodeLiteral(binaryStringArray[6...].joined())
            packet.value = value
            return (packet, remainder)
        } else {
            return decodeSubpackets(raw, packet: packet)
        }
    }
    
    func decodeLiteral(_ binaryString: String) -> (Int, String) {
        var binaryStringArray = Array(binaryString).map { String($0) }
        var foundLastGroup = false
        var literalTranslations = ""
        while !foundLastGroup {
            literalTranslations += binaryStringArray[1..<5].joined()
            foundLastGroup = binaryStringArray[0] == "0"
            binaryStringArray = Array(binaryStringArray[5...])
        }
        return (literalTranslations.binaryStringToInt(), binaryStringArray.joined())
    }
    
    func decodeSubpackets(_ binaryString: String, packet: Packet) -> (Packet, String) {
        var remainder = Array(binaryString).map { String($0) }
        if remainder[6] == "0" {
            let lengthOfSubpackets = remainder[7..<22].joined().binaryStringToInt()
            var subRemainder = Array(remainder[22..<(22 + lengthOfSubpackets)])
            remainder = Array(remainder[(22 + lengthOfSubpackets)...])
            while subRemainder.count > 0 {
                let (subpacket, newRemainder) = decodePacket(subRemainder.joined())
                subRemainder = Array(newRemainder).map { String($0) }
                packet.subpackets.append(subpacket)
            }
        } else {
            let numSubpackets = remainder[7..<18].joined().binaryStringToInt()
            remainder = Array(remainder[18...])
            for _ in 0..<numSubpackets {
                let (subpacket, newRemainder) = decodePacket(remainder.joined())
                remainder = Array(newRemainder).map { String($0) }
                packet.subpackets.append(subpacket)
            }
        }
        
        return (packet, remainder.joined())
    }
}

class Packet {
    let version: Int
    let typeId: Int
    var subpackets = [Packet]()
    var value = 0
    init(version: Int, typeId: Int) {
        self.version = version
        self.typeId = typeId
    }
}

extension String {
    func binaryStringToInt() -> Int {
        return Int(self, radix: 2)!
    }
}
