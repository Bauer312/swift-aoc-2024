import Testing

@testable import AdventOfCode

struct Day04Tests {
  // Smoke test data provided in the challenge question
  let testData = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

  @Test func testPart1() async throws {
    let challenge = Day04(data: testData)
    #expect(challenge.part1() as? Int ?? -1 == 18)
  }

  @Test func testPart2() async throws {
    let challenge = Day04(data: testData)
    #expect(challenge.part2() as? Int ?? -1 == 9)
  }
}
