import Foundation

class Input {
    var x: Int
    var m: Int
    var a: Int
    var s: Int

    init(x: Int, m: Int, a: Int, s: Int) {
        self.x = x
        self.m = m
        self.a = a
        self.s = s
    }
}

class Workflow {
    var name: String
    var conditions: [Condition]
    var outcome: String

    init(name: String, conditions: [Condition], outcome: String) {
        self.name = name
        self.conditions = conditions
        self.outcome = outcome
    }
}

class Condition {
    var id: String
    var isLess: Bool
    var threshold: Int
    var next: String

    init(id: String, isLess: Bool, threshold: Int, next: String) {
        self.id = id
        self.isLess = isLess
        self.threshold = threshold
        self.next = next
    }
}

func generateCondition(input: String) -> Condition? {
    do {
        let regex = try NSRegularExpression(pattern: "([a-zA-Z]+)([<>])(\\d+):([a-zA-Z]+)", options: [])
        let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))

        if let match = matches.first {
            let groups = (1..<match.numberOfRanges).map {
                (input as NSString).substring(with: match.range(at: $0))
            }

            // Ensure that the groups array has the expected number of elements
            guard groups.count == 4 else {
                print("Error: Unexpected number of groups in regex match")
                return nil
            }

            let id = groups[0]
            let isLess = groups[1] == "<"
            let threshold = Int(groups[2]) ?? 0
            let next = groups[3]

            return Condition(id: id, isLess: isLess, threshold: threshold, next: next)
        }
    } catch {
        print("Error parsing Regex: \(error)")
    }

    return nil
}

func generateInput(line: String) -> Input {
    do {
        let regex = try NSRegularExpression(pattern: "\\d+", options: [])
        let matches = regex.matches(in: line, options: [], range: NSRange(location: 0, length: line.utf16.count))

        let numbers = matches.map { match in
            (line as NSString).substring(with: match.range)
        }

        if numbers.count >= 4 {
            let nrs = numbers.prefix(4).compactMap { Int($0) }
            return Input(x: nrs[0], m: nrs[0], a: nrs[0], s: nrs[0])
        }

    } catch {
        print("Error creating regex: \(error)")
    } 

    return Input(x: 0, m: 0, a: 0, s: 0)
}


func generateFlow(line: String) -> Workflow {
    let parts = line.dropLast().split(separator: "{")
    var id = parts[0]
    var rawConditions = parts[1].split(separator: ",")
    var outcome = rawConditions[rawConditions.count-1]

    var conditions: [Condition] = []

    for i in 0..<rawConditions.count-1 {
        if let condition = generateCondition(input: String(rawConditions[i])) {
            conditions.append(condition)
        }
    }

    return Workflow(name: String(id), conditions: conditions, outcome: String(outcome))
}


func populateData(path: String, conditionsMap: inout [String : Workflow]) -> [Input] {
    var inputs: [Input] = []
    do {
        let content = try String(contentsOfFile: path, encoding: .utf8)

        let lines = content.components(separatedBy: .newlines)

        // Process each line
        for line in lines {
            let isWorkflow = line.first?.isLetter

            if isWorkflow == nil { // Whitespace
                continue
            }
            
            if isWorkflow != nil && isWorkflow! { // WorkFlow
                var newflow = generateFlow(line: line)
                conditionsMap[newflow.name] = newflow
                continue
            }

            // Input
            let input = generateInput(line: line) 
            inputs.append(input)
        }    

        return inputs
    } catch {
        print("Error while opening file")
    }

    return inputs
}

let path = "./day19_input.txt"

var conditionsMap = [String: Workflow]() 
var inputs = populateData(path: path, conditionsMap: &conditionsMap)

print(conditionsMap.count)
print(inputs.count)