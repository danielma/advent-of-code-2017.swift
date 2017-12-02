import Quick
import Nimble
@testable import AOC

class DayTwo_ChecksumSpec: QuickSpec {
  override func spec() {
    describe("part 1") {
      it("example") {
        let spreadsheet = Spreadsheet.parse("""
          5 1 9 5
          7 5 3
          2 4 6 8
          """)

        expect(Spreadsheet.checksum(spreadsheet)).to(equal(18))
      }
    }
  }
}
