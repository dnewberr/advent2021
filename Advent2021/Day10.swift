
extension String {
    func count(of needle: Character) -> Int {
        return reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}

final class Day10 {
    let charToPoints = [
        ")" : 3,
        "]" : 57,
        "}" : 1197,
        ">" : 25137
    ]
    
    let charToPoints2 = [
        ")" : 1,
        "]" : 2,
        "}" : 3,
        ">" : 4
    ]
    let fullInput = """
    {<{[<((<[<({<{(){}}(()())>[<<><>>((){})]}(<<{}{}>(<><>)>))(<[(<>{}){()()}]{{{}[]}(()())}>[
    ((<{[<([<<{[<(()())([]())>)<<<{}{}>{[][]}>{<<>>(()[])}>}<(((()[])[{}<>])[<[]{}>{{}[]}])[[({}{})
    ({(<[([((<(<[(<>{}){()[]}]<[[]<>]<(){}]>><{(<>())[<>{}]}{(<>[])(<>{})}>)([(<(){}>[(){}]){{()[]}{<>{}}}][<<[]
    {{{[(([{{{[{[(()())[<>[]]]{([]{}){()<>}}}]{{{((){})[[][]]}[[{}{}]<[]()>]}(<(<>()){{}{}>>([{}()
    [<{{{[[(<[(([<{}[]>{()()}][[<>{}]]))]([<<{{}[]}>>([(<>[])<(){}>][[{}{}](()())])]{[{[<><>]}((<>{})[
    {<[<[[<<(<<<<(<>[])(<>[])>{([]())}>[{{[]()}}<({}())[<>()]>]>{[((<>{})[[]<>])([()<>]{<>()})](((<>()
    ([({({[{(([<[<[]>]>]<<({[]()}<[]<>>)[[()[]]{[]{}}]>>))((<<{<<><>>}{(<>{})<[]()>}>([[<>{}]<<>{}>
    {(<([{{{{(((({{}[]}))){[(({}<>))({<><>}<[][]])][<<[]{}>[{}{}]>{<[]>{[]{}}}]})({[{([]<>)([]<>)}
    {([{{{(([<[[[<(){}>{()[]}][([]<>)<[]{}>]]<{(<>())[[]()]}[{(){}}[()<>]]>]([({[]{}}{()[])){{<>()}{()[]}}])>[<[
    [([{<{(<({<{[[<>{}][<>[]]]<{{}<>}<{}{}>>}[({()[]])[[<>()]({}<>)]]>{<([{}<>]<[]<>>)[{[]()}{{}[]}]>[[{[][]
    {{<(<{(<[<(((<[]<>><{}[]>))({(<>{}){[][]}}([[]()]({}<>))>)>[((((()<>)<<>[]>){(<>{}){<>{}}})(<({}(
    {{[{<{<([{[<{[{}{}]{(){}}}{{[]<>}<()[]>}>]<[({[][]}<{}<>>)(<{}{}><[]()>)]<[{<>{}}(()())]([[]{}]<[]<>>)>>>[{[{
    <(([<<{{<(([(({}{})[[]{}])[<{}>(<>{})]]<([{}{}]{()[]})>))({(<(()<>)<<><>>>(([]<>)))}<<<[()
    <<<(({{([{({({()()}<<>[]>)<{()[]}[<>()>>}){[<[<>{}][<><>]>[{()[]}[<><>]]]<<[<>[]]{<>()}>>}}[(<[[(){}](()
    <<[[{{([(([([[<>{}][(){}]])]{({{()}(<>{})}{{{}<>}{<><>}})(([<><>])({{}[]}<<><>>))})([{({()<>}<[][]>)}]))
    [(<<<<<{[<({[{{}[]}<()<>>]<[{}[]][[]<>]>})>[<<{(()())({}<>)}{({}())(<>[]]}><<<{}<>>([]<>)><[
    <<({({{([(<([[{}()]<[]{}>]<<<>()>>)><{(<{}<>><{}()>)<{(){}}[<>]>}{([[]{}][[]<>])<({}()){{}[
    {<{([[[[[{<<[[{}{}]([]<>)]{{{}()}[<><>]}><[<()()>[{}{}]](((){})<()>>>>}]<{({{([]()){{}<>}}<{<>{}}({}{}
    {[{[[<[((<(<<{<>}{()[]}>><{<<>[]>[()[]]}{{()()}[()[]]}>)(({[[]](<>[])}{({}())<{}()>})([[{}[]]<[]()>][{
    [{[(({[{{([[[<()()>{{}{}}]{([]<>){<><>}}]](<<<(){}>(()())>{[[]]{<>{}}>>))<[<((<>{}){(){}}){[{}<>]}>([[<><
    <{<(<([(<[({<<[]()>[[]{}]>(<{}<>>)}(<[{}[]][{}[]]>{<{}[]>[(){}]}))[<(<[]<>>{{}<>}]([[][]]<()<>>)>{({{}<>}[<>[
    {({({{<({[{[{<<>()>[[]{}]}](([{}<>]{()()})[([]()){[]()}})}[[((()())[()<>])(<<>{}><{}>)]]]<([{([]
    (<[([{({<([<(([]<>)<()[]>){{<>{}}[()()]}>])(([({[]()}<{}{}>)][<{{}[]}({})>[[<><>][<><>]]])<[({()[]}[[]{
    {{{<{{[[{[[<({[]()}{()[]})<[<>()][()()]>>(({{}{}}))][({[(){}](()[]]}){{<<>()>({})}{<{}[]>[{}<>]}}]]{[<
    {<([((<{<<<{(({}{})<<>[]>)(((){}){[]})}{({[]<>}[[]{}])<[{}[]][()()]>}}[{([<>()][<>{}]){(<>
    {([([(({[<[[[(())(<>[])]{[()()][<>]}]]>([{[(<><>)(<>())]<(()<>)[<><>]>}({{<>{}}({})}([{}][
    ([[[({[{{<{{{[{}()]{(){}}}[{()}({}[])]}[{[[]<>>(()[])}<{[][]}{[]}>]}>}}]}{[<[[[[(({}{}){{}[]}
    <[{<([<({((([[<>{}]([]())]<[()[]]<()<>>>){<<{}{}>[<><>]>[((){}){{}<>}]}))}({[({[()())(<>[])}{({}())}){([()[]
    {([[{[<<[[<{([<>()][{}{}])<([]{})(()[])>}{{{()()}{[][]}}<[[]{}]<<>{}>>}>(({<()()>({}())}[{<>[]}({}<>)])([[<
    ({[<{{[<{{(((([]<>){<>()})([()<>]([]{})))){{<{()()}[{}<>]>}({<{}[]>}{([]<>)<{}[]>})}}<<([{{}()}[{}[]]]<{(
    <({{([{[({<([({}())[()[]]]{([]{})})(([[]{}]{{}[]})([{}()><()<>>))>(<(({}{})<{}{}>)[{<><>}{[]
    [{[{<{([[[<[[{[][]}(<>{})]{{[]<>}[{}{}]}]><{({{}()}<[]()})}>]{{(<[[][]]{[]()}>{(()())(<>[])})(
    (<{(<[[<{[[<<([]<>)<{}{}>>({{}[]}({}()))>]({([[]<>]([]())){[<>{}]<{}()>}}[{({}())[(){}]}(({}{})[[]]
    <[<<([{[{<{{<[[][]]<<>[]>>({<>{}}[<><>])}([[{}<>]<()()>][<[][]>(()[])])}[({[()()][[]()]}[{{}()}<[]<>>])]>{<
    <(([[{(([[([[{{}()}{[]}]]<((<><>}({}[]))((()())[()[]])>)[{{<[]<>>((){})}}<(<(){}>{{}[]})({()}{{}<>})>]]<[(<{
    [{<(((<(<({(({{}()}{<><>})[{[][]}{(){}}])({{[]{}}[<>{}]>)})>((([<(<><>){{}<>}><[<>{}]>]([[<>[]][{}{}
    [<{{({([({({{{()<>}([][])>}((({}<>)(()[]))<(<>()){{}<>}>)){[([()()](<>[]))]{({[]}[[]{}])([[]<>
    {({[<{(<<([[[<{}{}>[{}{}]](<<>>(()))]{[([]<>)<{}{}>]<[<><>]>}]<[[{{}<>}<<>{}>][([]<>)<(){}
    ([{{{[[(<<[<[[<>]{[]}]((<>{})({}[]))>({{()[]}<<><>>}{{<>{}}({})})]{{{{[][]}<{}()>}}<[[<><>][{}<>]]<
    [<{<{<[{{[([(([]<>))[{<>()}<{}{}>]]{[<<>{}>[(){}]){<[][]>[<><>]}})](([<([]{})[{}()]>(({}())(<>{}))]
    [<[<{(<(([{<{([]{}){[][]}}><{[{}[]]([]<>)}[[()[]]<()()>]>}][{(<[(){}]{()<>}><<[]()>[[]()]>){[[<>[]](()[])
    <(<<<([[<([[({[]<>}<[]()>){{<>[]}[{}{}]}]([[[][]]<[]()>])]<{{(<><>){<>[]}}}{(<[][])(()[]))[([]{})[[
    (([{<{{([<<{({[]{}}[()[]])[<()()><()[]>]}[(<()>[()()])[[<>[]]]]>>{{{{<[]()>[()<>]}}{{<()[]>[()[]]}<[[][]]
    (<<[([[{{({<[([][])<{}()]][<()()>(()())]>})}<([[{(()<>)<[]()>}((()[])[<>{}])]]([<{(){}}({}<>)>][<
    [<<((<[<<{(((({}()))({<>{}}([]<>))){{<()<>><{}[]>}{(()())}}){({([]<>)<<>{}>})}}<{{<[()][<><>]>{{[]
    <{[<[((([{<{{{<>[]}[[]()]}([<><>])}>((<<<>()>({}<>)><[{}[]]<()[]>>)[{{[][]}{()<>}}[{()<>}(()[])]])}(([<{{
    {<{<[(({([<[<[[][])([]{})>[{(){}}[[]<>]]][(<{}<>>{()<>}){[<><>]{{}[]}}]>([[<[][]>{[]<>}]({[][]}(()()))]{
    (<{{{[{<{(<[({{}[]})]><<{(()<>)[{}{}]}{<()()>}>>)[[(({()<>}(<>{})))([<(){}>(()<>)]{((){})([][])})]
    <<[(<([<(({[{({}{})}<{()<>}{<>{}}>][([[]()](()<>))]}[[({{}()}<[]{}>)[<[]()>[()()]]]((<{}{}
    <<{[{[<{{{([<<<>{}>{()[]}>({{}[]}<<>{}>)][[<()[]>[{}[]]]({()<>}(()()))])[<<<<>()>{[]{}}>><{{[]{}}<()<>>}(<<>[
    [{{<({[([({{{(()())[<><>]}{[()()][(){}]}}}{[([<>[]])[{[]()}((){})]]([<[]{}>(()<>)]{[<>]})})(<
    <<<{{(({<{<[<<<>{}>>(<<>[]>{()()})]<([()<>])>>[(<({}[]){{}[]}>{[{}{}][[]()]})[<[<>[]]<()[]>>(<
    [([<<<(<[[[[[([]{}){{}()}}<<[]()>{[]}>][([<>[]]({}))[(()<>){()()}]]]]]>{[([[<([]())<{}<>>>({<>()}
    [([{{[[(({[<{[{}[]]{[][]]}<{<>()}[<>[]]>>(<{<>()}<[]()>>)]}))<<<<<{{()[]}{{}[]}}[<<>{}>]><{[{}<>]{(
    [{{{<((([{([{[[]()][<>()]}([[]()]{{}()})]{([{}{}](<>{}))({()<>}(<>{}))})<[({(){}}[()<>])}>}(
    {<<{{({[[[[[{[()]({})}<[<><>]{{}}}][[{()<>}({}{})][<<>[]>{<><>}]]]({<(<>)<<><>>>({<>()}<<>
    <[[[[({([[{<[{{}()}]{(()<>)<[]()>}>{[{<>{}}(()[])][{()[]}<()()>]}}]]<{[(({<>{}}{<>()})<[[]()]<<>{}>>)<((()[])
    ({{{<{[({[[[<{()<>}<<>[]>>{[[]<>][<>()]}]([(()<>)[[]()]]({{}[]}(()[]))]]][{{{<<>>({}<>)}<<<>{}
    [{[((<{<([[{<<()[]>[[][]]>}<{({})}[<{}[]>[[][]}]>]]<<{(([]<>)[[]()])}<{<{}()>{[]}}{[()[]]({})}>>
    [{([[{[({<[<(<<>{}>({}[]))([{}<>]{(){}})}({<[][]>}{[()()]<{}[]>})]<<[<(){}>[<>{}]][<<>{}>({}{
    [<([{<<[((([<[<>()]({}())><([]{})<{}[]>>]))[{[[[[]()]]]}{{[{[]()}([][])]{<[][]>{{}()}}}}])<(({{(<>()){
    {{[[<{{(({{{(<{}<>>{()[]})[<[]()>]}[{<[]{}>[()[]]}]}<[{[[]<>][[][]]}<<(){}>((){})>][([()<>]<<>>)<
    <<{[(([{<((({([][]){[]<>}}{({}())}))({[<<>{}><<>>]}{<[<>{}](()())><<{}[]>{()<>}>)))({[<(<>[
    <[<((<<[[<[((([]<>)<(){}>)[<(){}>])({<{}{}>{<><>}}<(()())<[]{}>>)]{{({(){}}(()[]))}<({<><>}({}()))>}
    [<{(<([{[({[{({}{})<{}()>}[{[]<>}({}<>)]]})[<[([{}[]][()[]])((<>()){{}<>})][[[(){}][[][]]][<
    <(({([[(<[[{(<<><>><{}()>)<(()()){()[]}>}({[()<>][{}[]]}([<>{}]<<><>>)}]]{{[<[<>[]]>({<><>}([]{}))][(([][])<
    {[[[[<<[{(({{{[]()}[{}[]]}}{[[()()][{}{}]]}){[{{{}()}}[[[][]]<()()>]]}){[{((()<>)[{}<>]){<<>()>[()()]}}(([{}<
    [[<<<{<({[<([[()<>]]({()<>})){[{{}[]}]}>][({[<()<>>({}[])]}((<<><>>[<>])[({}())<{}{}>]))]})>}>[{{(({{[
    {{[[{{(([[[[({[]()}<{}()>)<(()[])<<>[]>>]]<(<{[][]}<{}()>>(({})[[][]]))>]<<{({()[]}[(){}]]({
    ({{((<([<({<(<[]<>><<>[]>){[{}<>]}>(<[{}{}]>)}[<{{<>{}}{[]()}}[<<><>>[[][]]]>[[<()()><(){}>]{<
    [[[(({{<(<{<[{()[]}]({<>{}})>[<<<>()>{{}{}}>{({}<>)<<>()>}]}<({{()()}}<(()()){<><>}>){<((){})(<>()
    {<{{(<{{<[[({<<>>}<[(){}]({}())>)[<{()<>}[{}()]>[({}[])<()()>]]]]{<[({<>{}}{[][]})]{[(<>{})({}())]}
    [<[<{<<({[[(((<>())[{}<>]))<(({}[])(()[])){{{}{}}[[]<>]}>]<[(<{}{}]{{}{}})<(()<>)>][[{<>{}}<[
    [({<(<[([<({([<>()]{[][]}>{<<>[]>[[]()]}}[{<()<>>([]<>)}])<<<[[]()](())>><[<<>[]>{{}()}]{<()
    {{[{(<<{[{({[<[]()>{{}<>}]([()<>]{{}[]})}<<<[]()>[[]<>]><[<>{}][()()]>>)}<{<[{[]()}{<>{}}]>{({[][]}<[]
    [[{[<<<[{[[<({<>()}((){})){{<>[]}<(){}>}>[<(()<>)({}<>)>{<[]()>(<>)}]]]{<<{[<>[]]>>(<<{}()>(<>())>(
    {({{[([<{{{<((<><>)<()()>][<{}[]>{<>[]}]><({<>()}(()<>))({{}[]}<()[]>)>}([({{}[]})({{}()}[<>[]])])}
    {<[[({{((<[{[{<>()}(<>())]<({}[])<<>{}>>}([(()())<<>[]>]((<>[]){{}{}}))]{({<()()>(()<>)}[{[][]}([]())])<<[()
    ([{((({<<<{<{{<><>}(()<>)}>}>)[{{[[[[][]]]][<(<>{}){[]}>([{}()][[][]])]}<{([()()][<>()])(<[]()>
    <(((<(({<<[{<(()())>[[[][]]<[]{}>]}[{{<>()}(<><>)}(({}())({}()))]]>((<({{}[]}(<>())){({}[])
    <<{[(<([<(<{{[<>{}]}(<<>()>({}{}))}><({<<>()>(<><>)}<<[][]>[[]()]>)(([<>()){{}()})<[[][]]{<>{}
    <<[[([{{{{[<{[(){}]<[]()>}>[[([])<[]<>>>[({}{})([][])]]]}<<({<()[]><{}<>>}<{()<>}(<><>)>)>(([
    {[[[{{[{{((<{[{}[]](()[])}<(<>{})(<><>)>>){(<<<>{}>>)(([()[]]<[]{}})[({}[])(()())])})}}]}{[{{({({([]
    ([{[{((([[{{([[][]][{}[]])[{[]<>}<<>[]>]}}]][<[{[(<>{})[[]<>]][{[]<>}[(){}]]}]{<[[{}[]]{{}[]}]><(({}
    {(<(<{<<([<<<[{}{}]<{}{}>>><[{<><>}{{}<>}]([[]<>]{{}()})>>])>>{{[{{{<<<>()>[{}()]>{<[]()>[<>{}]}}}}<(<[(
    {<[{<<({[({(([[]<>](<><>)))[[[{}()]<()[]>]<{<>{}}[()<>]>]})([<([(){}]{<>[]})<<<>()><(){}>>><([<>[]>([][]))(<<
    [[[[<<(<({(<[{(){}}[()[]]][[{}[]]{[]{}}]>([{[][]}([]{})][{{}[]}<[]()>]))[{[{()()}({})]({(){}}[<>[]
    {<{(<[<(<<<{<[()<>]>{{()[]}}}<<([]<>)[()<>]>>>[{[<<><>>[{}<>]][<<><>>{(){}}]}[{[[]()]{<>()}}
    <[[<{<<[{{[[(([][])[[][]])<({}<>){{}[]}>]](<<({}[])[[][]]>((<><>))>[([()[]]((){}))])}}{[([((<>())
    {(<{[[((<<<{<{<>{}}([]{})><{()}>}[{(()<>)[[][]]}{<{}{}><{}{}>}]]<[[<{}()>]<([]{})>]{{[<>()]{{}{
    <{<{<{[{(((<(<[]{}>)([{}{}]({}{}))>([{[]<>}[[]{}]]<([]()){[]<>}>))<[(<[]{}>[()[]])]>)<{{[{{
    {{<([<{[(([(({[]<>}{()[]})<(()){(){}}>)[{({}<>)<[]<>>}<{{}()}<<><>>>>][{<({}<>)[()()]><<()<>>>
    [[[<([<<[[[{<<[][]>{()()}>[[(){}][<><>]]}{[{<>[]}[[]{}]]}]{<<({}<>)[[]]>[(<>[])]><<[()[]]<[]>>[{[]<>}({}{})]>
    {{{[{(<<{({{<{<>[]}>[{<><>}[()[]]]}[({()()})([<><>]<<>[]>)]}({[{{}[]}{{}[]}]}[(<[]()>[<>[]])({<><>}[(){}])]
    (<<[{[{[({<[{{(){}}<(){}>}{{()[]}[<>{}]}]{{(<>{})<{}>}{((){})}}>[{([<>()](<>{}))<{{}[]}[[]{}]>}{(<[][
    (<[[{<<{({<([<<>()>[<>()]]{{()<>}[<>[]]))>({<<<>()><()<>>>}({{[]<>}{{}()}}{<(){}><<>{}>}))})}<([<({[[]]{{}<
    ([((<[((([{<((()<>))[([])]>({(()<>)([]{})}([{}<>](()<>)))}{<[[[]()]([]{})]>}]({([{[]{}}][{(){}}{(){}
    (({{<[<{<{([<([]<>){()}><([]<>)<[][]>>]<<[()<>][[]<>]><{()()}>>)[(<[[]{}](<>())>{{{}()}{[]()}}
    """
    
    let testInput = """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """
    
    func run() {
//        pt1(testInput)
//        pt1(fullInput)
        
        pt2(testInput)
//        pt2(fullInput)
    }
    
    func chunkIt(_ inputLines: [String]) -> ([String: Int], Int) {
        var points = [Int]()
        var invalidCloses = [String: Int]()
        for line in inputLines {
            let lineArray = Array(line)
            var startIndex = 0
            
            var opens = [String]()
                         
            var invalidChar: String? = nil
            while startIndex < lineArray.count {
                let startChar = String(lineArray[startIndex])
                startIndex += 1
                
                if isOpen(startChar) {
                    opens.append(startChar)
                } else {
                    let lastOpen = opens.last!
                    opens = opens.dropLast()
                    let requiredClosed = pairs[lastOpen]!
                    if startChar != requiredClosed {
                        invalidChar = startChar
                        break
                    }
                }
            }
            
            if let invalidChar = invalidChar {
                invalidCloses[invalidChar, default: 0] += 1
            } else {
                let closes = opens.reversed()
                    .map { pairs[$0]! }
                
                var point = 0
                for requiredClose in closes {
                    point *= 5
                    point += charToPoints2[requiredClose]!
                }
                
                points.append(point)
            }
        }
        
        
        return (invalidCloses, points.sorted().middle!)
    }
    
    func isOpen(_ char: String) -> Bool {
        return pairs.keys.contains(char)
    }
    
    let pairs =  [
        "(": ")",
        "[": "]",
        "{": "}",
        "<": ">",
    ]
    
    
    private func pt1(_ input: String) {
        let inputArray = input.components(separatedBy: "\n")
        let answer = chunkIt(inputArray).0
            .map { key, val in
                return charToPoints[key, default: 0] * val
            }.reduce(0 , +)
        print("pt 1 - \(answer)")
    }
    
    private func pt2(_ input: String) {
        let inputArray = fullInput.components(separatedBy: "\n")
        let answer = chunkIt(inputArray).1
        print("pt 2 - \(answer)")
    }
}



/*
 
 {([(<{}[<>[]}>{[]{[(<()>
 GROUPS =
    {     }
     (
 
 */
