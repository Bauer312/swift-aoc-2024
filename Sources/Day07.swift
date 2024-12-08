import Algorithms

struct Day07: AdventDay {
  var data: String
  
  func isTrue(testValue: Int64, operators: [Int64], allowCombine: Bool = false) -> Bool {
    if operators.count == 1 {
      return testValue == operators[0] ? true : false
    }
    
    // Addition
    var newValue = operators[0] + operators[1]
    var newArray = operators
    newArray[1] = newValue
    newArray.remove(at: 0)
    if isTrue(testValue: testValue, operators: newArray, allowCombine: allowCombine) { return true }
    
    // Multiplication
    newValue = operators[0] * operators[1]
    newArray = operators
    newArray[1] = newValue
    newArray.remove(at: 0)
    if isTrue(testValue: testValue, operators: newArray, allowCombine: allowCombine) { return true }
    
    if allowCombine {
      // Combination
      newValue = Int64("\(operators[0])\(operators[1])") ?? 0
      newArray = operators
      newArray[1] = newValue
      newArray.remove(at: 0)
      if isTrue(testValue: testValue, operators: newArray, allowCombine: allowCombine) { return true }
    }
    
    return false
  }
  
  func part1() -> Any {
    var totalValue: Int64 = 0
    
    let lines = data.split(separator: "\n")
    for line in lines {
      let components = line.split(separator: ":")
      if components.count == 2 {
        let testValue = Int64(components[0].trimmingCharacters(in: .whitespaces)) ?? -1
        let operators: [Int64] = components[1].trimmingCharacters(in: .whitespaces).split(separator: " ").map {
          Int64($0) ?? -1
        }
        
        if isTrue(testValue: testValue, operators: operators, allowCombine: false) {
          //print(operators)
          totalValue += testValue
        }
      }
    }

    return totalValue
  }

  func part2() -> Any {
    var totalValue: Int64 = 0
    
    let lines = data.split(separator: "\n")
    for line in lines {
      let components = line.split(separator: ":")
      if components.count == 2 {
        let testValue = Int64(components[0].trimmingCharacters(in: .whitespaces)) ?? -1
        let operators: [Int64] = components[1].trimmingCharacters(in: .whitespaces).split(separator: " ").map {
          Int64($0) ?? -1
        }
        
        if isTrue(testValue: testValue, operators: operators, allowCombine: true) {
          //print(operators)
          totalValue += testValue
        }
      }
    }

    return totalValue
  }
}
