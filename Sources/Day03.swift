import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() -> Any {
    enum state {
      case invalid, m, u, l, first_number, second_number
    }
    
    var totalAmount = 0
    
    var firstNumber = ""
    var secondNumber = ""
    var currentState: state = .invalid
    for char in data {
      switch currentState {
      case .invalid:
        currentState = char == "m" ?  .m : .invalid
      case .m:
        currentState = char == "u" ?  .u : .invalid
      case .u:
        currentState = char == "l" ?  .l : .invalid
      case .l:
        currentState = char == "(" ?  .first_number : .invalid
        if currentState == .first_number {
          firstNumber = ""
          secondNumber = ""
        }
      case .first_number:
        if char == "0" || char == "1" || char == "2" || char == "3" ||
            char == "4" || char == "5" || char == "6" || char == "7" ||
            char == "8" || char == "9" {
          firstNumber += String(char)
        } else if char == "," {
          currentState = .second_number
        } else {
          currentState = .invalid
        }
      case .second_number:
        if char == "0" || char == "1" || char == "2" || char == "3" ||
            char == "4" || char == "5" || char == "6" || char == "7" ||
            char == "8" || char == "9" {
          secondNumber += String(char)
        } else if char == ")" {
          print("Multiply \(firstNumber) by \(secondNumber)")
          totalAmount += (Int(firstNumber) ?? 0) * (Int(secondNumber) ?? 0)
          currentState = .invalid
        } else {
          currentState = .invalid
        }
      }
    }
    return totalAmount
  }

  func part2() -> Any {
    enum state {
      case invalid, m, u, l, first_number, second_number, d, o, n, apostrophe, t, open_paren_enabling, open_paren_disabling
    }
    
    var totalAmount = 0
    var enabled = true
    
    var firstNumber = ""
    var secondNumber = ""
    var currentState: state = .invalid
    for char in data {
      switch currentState {
      case .invalid:
        if char == "m" {
          currentState = .m
        } else if char == "d" {
          currentState = .d
        } else {
          currentState = .invalid
        }
      case .m:
        currentState = char == "u" ?  .u : .invalid
      case .u:
        currentState = char == "l" ?  .l : .invalid
      case .l:
        currentState = char == "(" ?  .first_number : .invalid
        if currentState == .first_number {
          firstNumber = ""
          secondNumber = ""
        }
      case .first_number:
        if char == "0" || char == "1" || char == "2" || char == "3" ||
            char == "4" || char == "5" || char == "6" || char == "7" ||
            char == "8" || char == "9" {
          firstNumber += String(char)
        } else if char == "," {
          currentState = .second_number
        } else {
          currentState = .invalid
        }
      case .second_number:
        if char == "0" || char == "1" || char == "2" || char == "3" ||
            char == "4" || char == "5" || char == "6" || char == "7" ||
            char == "8" || char == "9" {
          secondNumber += String(char)
        } else if char == ")" {
          if enabled {
            //print("Multiply \(firstNumber) by \(secondNumber)")
            totalAmount += (Int(firstNumber) ?? 0) * (Int(secondNumber) ?? 0)
          }
          currentState = .invalid
        } else {
          currentState = .invalid
        }
      case .d:
        if char == "o" {
          currentState = .o
        } else if char == "m" {
          currentState = .m
        } else {
          currentState = .invalid
        }
      case .o:
        if char == "n" {
          currentState = .n
        } else if char == "(" {
          currentState = .open_paren_enabling
        } else if char == "m" {
          currentState = .m
        } else {
          currentState = .invalid
        }
      case .n:
        if char == "'" {
          currentState = .apostrophe
        } else if char == "m" {
          currentState = .m
        } else {
          currentState = .invalid
        }
      case .apostrophe:
        if char == "t" {
          currentState = .t
        } else if char == "m" {
          currentState = .m
        } else {
          currentState = .invalid
        }
      case .t:
        if char == "(" {
          currentState = .open_paren_disabling
        } else if char == "m" {
          currentState = .m
        } else {
          currentState = .invalid
        }
      case .open_paren_disabling:
        if char == ")" {
          enabled = false
          currentState = .invalid
        } else if char == "m" {
          currentState = .m
        } else {
          currentState = .invalid
        }
      case .open_paren_enabling:
        if char == ")" {
          enabled = true
          currentState = .invalid
        } else if char == "m" {
          currentState = .m
        } else {
          currentState = .invalid
        }
      }
    }
    return totalAmount
  }
}
