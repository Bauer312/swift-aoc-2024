import Algorithms

struct Day05: AdventDay {
  var data: String

  func isValidUpdate(update: [Int], orderingRules: [(Int,Int)]) -> Bool {
    for (idx, val) in update.enumerated() {
      // Are there any rules that say number before this must come after?
      for bIdx in 0..<idx {
        //print("Are there any rules that say \(update[bIdx]) must come after \(val)?")
        for rule in orderingRules {
          if rule == (val, update[bIdx]) {
            //print("yes")
            return false
          }
        }
      }
      
      // Are there any rules that say numbers after this must come before?
      for aIdx in (idx+1)..<update.count {
        //print("Are there any rules that say \(update[aIdx]) must come before \(val)?")
        for rule in orderingRules {
          if rule == (update[aIdx], val) {
            //print("yes")
            return false
          }
        }
      }
    }
    return true
  }
  
  func reorderUpdate(update: [Int], orderingRules: [(Int,Int)]) -> [Int] {
    var newArr = update
    // Make sure this doesn't run forever
    for failsafe in 0..<25 {
      for idx in 0..<(update.count-1) {
        // If 0 must be after 1, swap them
        for rule in orderingRules {
          if rule == (newArr[idx+1], newArr[idx]) {
            let swap = newArr[idx]
            newArr[idx] = newArr[idx+1]
            newArr[idx+1] = swap
            continue
          }
        }
      }
      if isValidUpdate(update: newArr, orderingRules: orderingRules) {
        return newArr
      }
    }
    
    return newArr
  }
  
  func part1() -> Any {
    // The data consiste of ordering rules and updates
    var orderingRules: [(Int,Int)] = [(Int,Int)]()
    var updates: [[Int]] = [[Int]]()
    
    // Populate the data sets
    let lines = data.split(separator: "\n")
    for line in lines {
      if line.isEmpty { continue }
      
      let pipeComponents = line.split(separator: "|")
      if pipeComponents.count == 2 {
        orderingRules.append((Int(pipeComponents[0]) ?? 0, Int(pipeComponents[1]) ?? 0))
      } else {
        let commaComponents = line.split(separator: ",")
        if commaComponents.count > 0 {
          updates.append(commaComponents.map { Int($0) ?? 0 })
        }
      }
    }
    
    var validCount = 0
    var sumOfMiddles = 0
    for update in updates {
      if isValidUpdate(update: update, orderingRules: orderingRules) {
        let middleElement = Int(update.count / 2)
        //print(update)
        //print("Middle Element: \(update[middleElement])")
        validCount += 1
        sumOfMiddles += update[middleElement]
      }
    }
    //print("Valid updates: \(validCount)")
    
    return sumOfMiddles
  }

  func part2() -> Any {
    // The data consiste of ordering rules and updates
    var orderingRules: [(Int,Int)] = [(Int,Int)]()
    var updates: [[Int]] = [[Int]]()
    
    // Populate the data sets
    let lines = data.split(separator: "\n")
    for line in lines {
      if line.isEmpty { continue }
      
      let pipeComponents = line.split(separator: "|")
      if pipeComponents.count == 2 {
        orderingRules.append((Int(pipeComponents[0]) ?? 0, Int(pipeComponents[1]) ?? 0))
      } else {
        let commaComponents = line.split(separator: ",")
        if commaComponents.count > 0 {
          updates.append(commaComponents.map { Int($0) ?? 0 })
        }
      }
    }
    
    var validCount = 0
    var sumOfMiddles = 0
    for update in updates {
      if !isValidUpdate(update: update, orderingRules: orderingRules) {
        let newArr = reorderUpdate(update: update, orderingRules: orderingRules)
        if isValidUpdate(update: newArr, orderingRules: orderingRules) {
          let middleElement = Int(newArr.count / 2)
          //print("Ordered: \(newArr)")
          //print("Middle Element: \(update[middleElement])")
          validCount += 1
          sumOfMiddles += newArr[middleElement]
        } else {
          print("Still not ordered: \(newArr) -> original \(update)")
        }
      }
    }
    //print("Valid updates: \(validCount)")
    
    return sumOfMiddles
  }
}
