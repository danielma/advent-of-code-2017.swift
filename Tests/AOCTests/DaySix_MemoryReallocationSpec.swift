import Quick
import Nimble
@testable import AOC

class DaySix_MemoryReallocationSpec: QuickSpec {
  override func spec() {
    describe("part 1") {
      var memoryContainer: MemoryReallocation.MemoryContainer!

      beforeEach {
        memoryContainer = MemoryReallocation.MemoryContainer([0, 2, 7, 0])
      }

      it("move 1") {
        memoryContainer.reallocate()

        expect(memoryContainer.blocks) == [2, 4, 1, 2]
        expect(memoryContainer.reallocationCount) == 1
        expect(memoryContainer.detectedInfiniteLoop) == false
      }

      it("move 2") {
        memoryContainer.reallocate()
        memoryContainer.reallocate()

        expect(memoryContainer.blocks) == [3, 1, 2, 3]
        expect(memoryContainer.reallocationCount) == 2
        expect(memoryContainer.detectedInfiniteLoop) == false
      }

      it("move 3") {
        memoryContainer.reallocate()
        memoryContainer.reallocate()
        memoryContainer.reallocate()

        expect(memoryContainer.blocks) == [0, 2, 3, 4]
        expect(memoryContainer.reallocationCount) == 3
        expect(memoryContainer.detectedInfiniteLoop) == false
      }

      it("move 4") {
        memoryContainer.reallocate()
        memoryContainer.reallocate()
        memoryContainer.reallocate()
        memoryContainer.reallocate()

        expect(memoryContainer.blocks) == [1, 3, 4, 1]
        expect(memoryContainer.reallocationCount) == 4
        expect(memoryContainer.detectedInfiniteLoop) == false
      }

      it("move 5") {
        memoryContainer.reallocate()
        memoryContainer.reallocate()
        memoryContainer.reallocate()
        memoryContainer.reallocate()
        memoryContainer.reallocate()

        expect(memoryContainer.blocks) == [2, 4, 1, 2]
        expect(memoryContainer.reallocationCount) == 5
        expect(memoryContainer.detectedInfiniteLoop) == true
      }

      it("how many moves?") {
        memoryContainer.reallocateUntilInfiniteLoopDetected()

        expect(memoryContainer.blocks) == [2, 4, 1, 2]
        expect(memoryContainer.reallocationCount) == 5
        expect(memoryContainer.detectedInfiniteLoop) == true
      }
    }

    fdescribe("part 2") {
      var memoryContainer: MemoryReallocation.MemoryContainer!

      beforeEach {
        memoryContainer = MemoryReallocation.MemoryContainer([0, 2, 7, 0])
      }

      it("how long is the loop?") {
        memoryContainer.reallocateUntilInfiniteLoopDetected()

        expect(memoryContainer.blocks) == [2, 4, 1, 2]
        expect(memoryContainer.reallocationCount) == 5
        expect(memoryContainer.detectedInfiniteLoop) == true
        expect(memoryContainer.infiniteLoopSize) == 4
      }
    }
  }
}

