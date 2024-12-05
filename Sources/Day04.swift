import Algorithms

struct Day04: AdventDay {
  var data: String

  func part1() -> Any {
    var counter = 0
    
    let localCopy = data.split(separator: "\n").map {
      Array($0)
    }

    let xCompareLimit = localCopy[0].count - 3
    let yCompareLimit = localCopy.count - 3
    
    for yIdx in 0..<localCopy.count {
      for xIdx in 0..<(localCopy[yIdx].count) {
        
        if xIdx < xCompareLimit {
          // Horizontal
          if localCopy[yIdx][xIdx] == "X" && localCopy[yIdx][xIdx+1] == "M" && localCopy[yIdx][xIdx+2] == "A" && localCopy[yIdx][xIdx+3] == "S" { counter += 1 }
          if localCopy[yIdx][xIdx] == "S" && localCopy[yIdx][xIdx+1] == "A" && localCopy[yIdx][xIdx+2] == "M" && localCopy[yIdx][xIdx+3] == "X" { counter += 1 }
        }
        
        if yIdx < yCompareLimit {
          //Vertical
          if localCopy[yIdx][xIdx] == "X" && localCopy[yIdx+1][xIdx] == "M" && localCopy[yIdx+2][xIdx] == "A" && localCopy[yIdx+3][xIdx] == "S" { counter += 1 }
          if localCopy[yIdx][xIdx] == "S" && localCopy[yIdx+1][xIdx] == "A" && localCopy[yIdx+2][xIdx] == "M" && localCopy[yIdx+3][xIdx] == "X" { counter += 1 }
        }
        if xIdx < xCompareLimit && yIdx < yCompareLimit {
          // Diagonal
          if localCopy[yIdx][xIdx] == "X" && localCopy[yIdx+1][xIdx+1] == "M" && localCopy[yIdx+2][xIdx+2] == "A" && localCopy[yIdx+3][xIdx+3] == "S" { counter += 1 }
          if localCopy[yIdx][xIdx] == "S" && localCopy[yIdx+1][xIdx+1] == "A" && localCopy[yIdx+2][xIdx+2] == "M" && localCopy[yIdx+3][xIdx+3] == "X" { counter += 1 }
          if localCopy[yIdx+3][xIdx] == "X" && localCopy[yIdx+2][xIdx+1] == "M" && localCopy[yIdx+1][xIdx+2] == "A" && localCopy[yIdx][xIdx+3] == "S" { counter += 1 }
          if localCopy[yIdx+3][xIdx] == "S" && localCopy[yIdx+2][xIdx+1] == "A" && localCopy[yIdx+1][xIdx+2] == "M" && localCopy[yIdx][xIdx+3] == "X" { counter += 1 }
        }
      }
    }
    
    return counter
  }

  func part2() -> Any {
    var counter = 0
    
    let localCopy = data.split(separator: "\n").map {
      Array($0)
    }

    let xCompareLimit = localCopy[0].count - 2
    let yCompareLimit = localCopy.count - 2
    
    for yIdx in 0..<localCopy.count {
      for xIdx in 0..<(localCopy[yIdx].count) {
        if xIdx < xCompareLimit  && yIdx < yCompareLimit {
          if localCopy[yIdx+1][xIdx+1] == "A" {
            if localCopy[yIdx][xIdx] == "M" || localCopy[yIdx][xIdx] == "S" {
              if localCopy[yIdx][xIdx] == "M" && localCopy[yIdx+2][xIdx+2] == "S" && localCopy[yIdx+2][xIdx] == "M" && localCopy[yIdx][xIdx+2] == "S" { counter += 1 }
              if localCopy[yIdx][xIdx] == "M" && localCopy[yIdx+2][xIdx+2] == "S" && localCopy[yIdx+2][xIdx] == "S" && localCopy[yIdx][xIdx+2] == "M" { counter += 1 }
              if localCopy[yIdx][xIdx] == "S" && localCopy[yIdx+2][xIdx+2] == "M" && localCopy[yIdx+2][xIdx] == "M" && localCopy[yIdx][xIdx+2] == "S" { counter += 1 }
              if localCopy[yIdx][xIdx] == "S" && localCopy[yIdx+2][xIdx+2] == "M" && localCopy[yIdx+2][xIdx] == "S" && localCopy[yIdx][xIdx+2] == "M" { counter += 1 }
            }
          }
        }
      }
    }
    
    return counter
  }
}
