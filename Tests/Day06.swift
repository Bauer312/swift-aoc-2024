import Testing

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day06Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

  @Test func testPart1() async throws {
    let challenge = Day06(data: testData)
    #expect(challenge.part1() as? Int ?? -1 == 41)
  }

  @Test func testPart2() async throws {
    let challenge = Day06(data: testData)
    #expect(challenge.part2() as? Int ?? -1 == 6)
  }
}
