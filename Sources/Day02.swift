//
//  Day01 2.swift
//  AdventOfCode
//
//  Created by Brian Bauer on 12/2/24.
//


import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Two integers per line, the first represents the location IDs from
  // the first group of historians, and the second represents the location IDs
  // from the second group of historians.
  var entities: (first: [Int], second: [Int]) {
    let tupleArr = data.split(separator: "\n").map {
      let components = $0.split(separator: " ", omittingEmptySubsequences: true)
      return (Int(components[0]) ?? -1, Int(components[1]) ?? -1)
    }
    var result: (first: [Int], second: [Int]) = ([Int](), [Int]())
    for tupleItem in tupleArr {
      result.first.append(tupleItem.0)
      result.second.append(tupleItem.1)
    }
    return result
  }

  func part1() -> Any {
    // Sort each array independently
    let sortedEntities: (first: [Int], second: [Int]) = (entities.first.sorted(), entities.second.sorted())
    
    // Iterate and sum the differences
    var totalDistance = 0
    for (index, element) in sortedEntities.first.enumerated() {
      let distance = abs(element - sortedEntities.second[index])
      totalDistance += distance
    }
    return totalDistance
  }

  func part2() -> Any {
    var similarityScore = 0
    for element in entities.first {
      let count = entities.second.filter({ $0 == element }).count
      similarityScore += element * count
    }
    return similarityScore
  }
}
