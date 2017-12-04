import Quick
import Nimble
@testable import AOC

class DayThree_SpiralMemorySpec: QuickSpec {
  override func spec() {
    describe("part 1") {
      it("1") {
        expect(SpiralMemory.moves(from: 1, to: 1)).to(equal(0))
      }

      it("12") {
        expect(SpiralMemory.moves(from: 12, to: 1)).to(equal(3))
      }

      it("23") {
        expect(SpiralMemory.moves(from: 23, to: 1)).to(equal(2))
      }

      it("24") {
        expect(SpiralMemory.moves(from: 24, to: 1)) == 3
      }

      it("1024") {
        expect(SpiralMemory.moves(from: 1024, to: 1)).to(equal(31))
      }
    }

    describe("part 2") {
      it("1") {
        expect(SpiralMemory.valueAt(0)) == 1
      }

      it("2") {
        expect(SpiralMemory.valueAt(1)) == 1
      }

      it("4") {
        expect(SpiralMemory.valueAt(4)) == 4
      }

      it("5") {
        expect(SpiralMemory.valueAt(5)) == 5
      }

      it("first value larger than") {
        expect(SpiralMemory.firstValueLargerThan(5)) == 10
        expect(SpiralMemory.firstValueLargerThan(747)) == 806
      }
    }
  }
}

