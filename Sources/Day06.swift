import Algorithms

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  
  var grid: [[Character]] {
    data.split(separator: "\n").map {
      Array($0)
    }
  }
  
  func guardLocation(board: [[Character]]) -> (Int, Int) {
    for yIdx in 0..<board.count {
      for xIdx in 0..<board[0].count {
        if board[yIdx][xIdx] == "^" {
          return (xIdx, yIdx)
        }
      }
    }
    return (0, 0)
  }
  
  enum direction { case up, down, left, right }
  
  enum result { case loop, exited(Int) }

  func execute(board: [[Character]]) -> result {
    // Get starting position
    var localCopy = board
    let startingLocation = guardLocation(board: board)
    var curLocation = startingLocation
    var curDirection = direction.up
    
    var counter = 0
    var keepGoing = true
    while keepGoing {
      switch curDirection {
      case .up:
        if curLocation.1 == 0 {
          // Exit the board
          localCopy[curLocation.1][curLocation.0] = "X"
          keepGoing = false
        } else if localCopy[curLocation.1-1][curLocation.0] == "#" ||
                    localCopy[curLocation.1-1][curLocation.0] == "O"{
          curDirection = .right
        } else {
          localCopy[curLocation.1][curLocation.0] = "X"
          curLocation.1 -= 1
          localCopy[curLocation.1][curLocation.0] = "^"
        }
        
      case .right:
        if curLocation.0 == localCopy[curLocation.1].count - 1 {
          // Exit the board
          localCopy[curLocation.1][curLocation.0] = "X"
          keepGoing = false
        } else if localCopy[curLocation.1][curLocation.0+1] == "#" ||
                    localCopy[curLocation.1][curLocation.0+1] == "O" {
          curDirection = .down
        } else {
          localCopy[curLocation.1][curLocation.0] = "X"
          curLocation.0 += 1
          localCopy[curLocation.1][curLocation.0] = "^"
        }
      case .down:
        if curLocation.1 == localCopy.count - 1 {
          // Exit the board
          localCopy[curLocation.1][curLocation.0] = "X"
          keepGoing = false
        } else if localCopy[curLocation.1+1][curLocation.0] == "#" ||
                    localCopy[curLocation.1+1][curLocation.0] == "O" {
          curDirection = .left
        } else {
          localCopy[curLocation.1][curLocation.0] = "X"
          curLocation.1 += 1
          localCopy[curLocation.1][curLocation.0] = "^"
        }
      case .left:
        if curLocation.0 == 0 {
          // Exit the board
          localCopy[curLocation.1][curLocation.0] = "X"
          keepGoing = false
        } else if localCopy[curLocation.1][curLocation.0-1] == "#" ||
                    localCopy[curLocation.1][curLocation.0-1] == "O" {
          curDirection = .up
        } else {
          localCopy[curLocation.1][curLocation.0] = "X"
          curLocation.0 -= 1
          localCopy[curLocation.1][curLocation.0] = "^"
        }
      }
      counter += 1
      if counter == 50_000 {
        return .loop
      } else if curLocation == startingLocation && curDirection == .up {
        return .loop
      }
    }
    
    // Count the number of X's on the board
    return .exited(localCopy.reduce(0, { val, row in
      val + row.reduce(0, { x, y in
        x + (y == "X" ? 1 : 0)
      })
    }))
  }
  
  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let result = execute(board: grid)
    switch result {
    case .loop:
      return -1
    case .exited(let count):
      return count
    }
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var localCopy = grid
    var counter = 0
    var failed = 0
    for yIdx in 0..<localCopy.count {
      for xIdx in 0..<localCopy[yIdx].count {
        if localCopy[yIdx][xIdx] == "." {
          localCopy[yIdx][xIdx] = "O"
          let result = execute(board: localCopy)
          switch result {
          case .loop:
            counter += 1
            /*
            print("_______________________")
            for row in localCopy {
             print(row)
            }
            print("_______________________")
             */
          default:
            failed += 1
            if failed % 500 == 0 {
              print("Failed: \(failed)")
            }
          }
          localCopy[yIdx][xIdx] = "."
        }
      }
    }
    return counter
  }
}
