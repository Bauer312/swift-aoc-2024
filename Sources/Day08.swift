import Algorithms

struct Day08: AdventDay {
  var data: String
  
  var grid: [[Character]] {
    data.split(separator: "\n").map {
      Array($0)
    }
  }
  
  var uniqueFrequencies: Set<Character> {
    var result = Set<Character>()
    
    for row in grid {
      for element in row {
        if element != "." {
          result.insert(element)
        }
      }
    }
    return result
  }
  
  var antennaLocations: Dictionary<Character, [(x: Int, y: Int)]> {
    var result = Dictionary<Character, [(Int, Int)]>()
    
    for (yIdx, row) in grid.enumerated() {
      for (xIdx, element) in row.enumerated() {
        if element != "." {
          var arr = result[element] ?? [(Int, Int)]()
          arr.append((xIdx, yIdx))
          result[element] = arr
        }
      }
    }
    
    return result
  }

  func part1() -> Any {
    var localCopy = grid
    var antinodes = [(Int, Int)]()
    
    let maxX = grid[0].count - 1
    let maxY = grid.count - 1
    
    // Get all of the antenna locations
    for antenna in antennaLocations {
      let values = antenna.value
      for (idx, value) in values.enumerated() {
        for (otherIdx, otherValue) in values.enumerated() {
          if idx != otherIdx {
            let diffX = abs(value.x - otherValue.x)
            let diffY = abs(value.y - otherValue.y)
            
            if value.x > otherValue.x {
              if value.y > otherValue.y {
                antinodes.append((otherValue.x - diffX, otherValue.y - diffY))
              } else {
                antinodes.append((otherValue.x - diffX, otherValue.y + diffY))
              }
            } else {
              if value.y > otherValue.y {
                antinodes.append((otherValue.x + diffX, otherValue.y - diffY))
              } else {
                antinodes.append((otherValue.x + diffX, otherValue.y + diffY))
              }
            }
          }
        }
      }
    }
    
    for antinode in antinodes {
      if antinode.0 >= 0 && antinode.0 <= maxX && antinode.1 >= 0 && antinode.1 <= maxY {
        localCopy[antinode.1][antinode.0] = "#"
      }
    }
    
    var antinodeCount = 0
    for row in localCopy {
      for element in row {
        if element == "#" { antinodeCount += 1 }
      }
    }
    
    return antinodeCount
  }

  func part2() -> Any {
    var localCopy = grid
    var antinodes = [(Int, Int)]()
    
    let maxX = grid[0].count - 1
    let maxY = grid.count - 1
    
    // Get all of the antenna locations
    for antenna in antennaLocations {
      let values = antenna.value
      for (idx, value) in values.enumerated() {
        for (otherIdx, otherValue) in values.enumerated() {
          if idx != otherIdx {
            let diffX = abs(value.x - otherValue.x)
            let diffY = abs(value.y - otherValue.y)
            
            antinodes.append(value)
            antinodes.append(otherValue)
            
            if value.x > otherValue.x {
              if value.y > otherValue.y {
                var nextX = otherValue.x - diffX
                var nextY = otherValue.y - diffY
                while nextX >= 0 && nextY >= 0 {
                  antinodes.append((nextX, nextY))
                  nextX -= diffX
                  nextY -= diffY
                }
              } else {
                var nextX = otherValue.x - diffX
                var nextY = otherValue.y + diffY
                while nextX >= 0 && nextY <= maxY {
                  antinodes.append((nextX, nextY))
                  nextX -= diffX
                  nextY += diffY
                }
              }
            } else {
              if value.y > otherValue.y {
                var nextX = otherValue.x + diffX
                var nextY = otherValue.y - diffY
                while nextX <= maxX && nextY >= 0 {
                  antinodes.append((nextX, nextY))
                  nextX += diffX
                  nextY -= diffY
                }
                //antinodes.append((otherValue.x + diffX, otherValue.y - diffY))
              } else {
                var nextX = otherValue.x + diffX
                var nextY = otherValue.y + diffY
                while nextX <= maxX && nextY <= maxY {
                  antinodes.append((nextX, nextY))
                  nextX += diffX
                  nextY += diffY
                }
              }
            }
          }
        }
      }
    }
    
    
    for antinode in antinodes {
      localCopy[antinode.1][antinode.0] = "#"
    }
    
    var antinodeCount = 0
    for row in localCopy {
      for element in row {
        if element == "#" { antinodeCount += 1 }
      }
    }
    
    return antinodeCount
  }
}
