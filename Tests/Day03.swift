//
//  Day02Tests.swift
//  AdventOfCode
//
//  Created by Brian Bauer on 12/2/24.
//


import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day03Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """
  let testData2 = """
    xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    """

  @Test func testPart1() async throws {
    let challenge = Day03(data: testData)
    #expect(challenge.part1() as? Int ?? -1 == 161)
  }

  @Test func testPart2() async throws {
    let challenge = Day03(data: testData2)
    #expect(challenge.part2() as? Int ?? -1 == 48)
  }
}
