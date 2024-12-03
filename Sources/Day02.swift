//
//  Day01 2.swift
//  AdventOfCode
//
//  Created by Brian Bauer on 12/2/24.
//


import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Each line contains any number of reports separated by spaces
  var entities: [[Int]] {
    data.split(separator: "\n", omittingEmptySubsequences: true).map {
      $0.split(separator: " ", omittingEmptySubsequences: true).compactMap { Int($0) }
    }
  }
  
  func testReport(report: [Int]) -> Bool {
    enum testDirection {
      case increasing, decreasing
    }
    
    // Return true if the report is safe
    var previous: Int?
    var direction: testDirection?

    
    for element in report {
      if let previous {
        let diff = abs(element - previous)
        
        if diff < 1 || diff > 3 { return false }
        
        if let direction {
          if direction == .increasing {
            if element <= previous { return false }
          } else {
            if element >= previous { return false }
          }
        } else {
          direction = element > previous ? .increasing : .decreasing
        }
      }
      previous = element
    }
    
    return true
  }

  func part1() -> Any {
    // Return the count of reports that are considered safe
    return entities.filter({ report in
      testReport(report: report)
    }).count
  }

  func part2() -> Any {
    // Return the count of reports that are considered safe,
    // allowing for a single report to be removed
    return entities.filter({ report in
      if testReport(report: report) == true { return true }
      for idx in 0..<report.count {
        var alteredReport = report
        alteredReport.remove(at: idx)
        if testReport(report: alteredReport) == true { return true }
      }
      return false
    }).count
  }
}
