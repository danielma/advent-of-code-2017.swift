import Quick
import Nimble
@testable import AOC

class DayThree_SpiralMemorySpec: QuickSpec {
  override func spec() {
    fdescribe("part 1") {
      it("1") {
        expect(SpiralMemory.moves(from: 1, to: 1)).to(equal(0))
      }

      it("12") {
        expect(SpiralMemory.moves(from: 12, to: 1)).to(equal(3))
      }

      it("23") {
        expect(SpiralMemory.moves(from: 23, to: 1)).to(equal(2))
      }

      it("1024") {
        expect(SpiralMemory.moves(from: 1024, to: 1)).to(equal(31))
      }
    }
  }
}

