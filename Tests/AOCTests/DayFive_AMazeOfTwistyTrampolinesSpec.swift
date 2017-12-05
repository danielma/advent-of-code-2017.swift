import Quick
import Nimble
@testable import AOC

class DayFive_AMazeOfTwistyTrampolinesSpec: QuickSpec {
  override func spec() {
    describe("part 1") {
      var maze: AMazeOfTwistyTrampolines.Maze!

      beforeEach {
        maze = AMazeOfTwistyTrampolines.mazePartOne([0, 3, 0, 1, -3])
      }

      it("move 1") {
        maze.jump()

        expect(maze.currentIndex) == 0
        expect(maze.toArray()) == [1, 3, 0, 1, -3]
        expect(maze.isOut) == false
      }

      it("move 2") {
        maze.jump()
        maze.jump()

        expect(maze.currentIndex) == 1
        expect(maze.toArray()) == [2, 3, 0, 1, -3]
        expect(maze.isOut) == false
      }

      it("move 3") {
        maze.jump()
        maze.jump()
        maze.jump()

        expect(maze.currentIndex) == 4
        expect(maze.toArray()) == [2, 4, 0, 1, -3]
        expect(maze.isOut) == false
      }

      it("move 4") {
        maze.jump()
        maze.jump()
        maze.jump()
        maze.jump()

        expect(maze.currentIndex) == 1
        expect(maze.toArray()) == [2, 4, 0, 1, -2]
        expect(maze.isOut) == false
      }

      it("move 5") {
        maze.jump()
        maze.jump()
        maze.jump()
        maze.jump()
        maze.jump()

        expect(maze.currentIndex) == 5
        expect(maze.toArray()) == [2, 5, 0, 1, -2]
        expect(maze.isOut) == true
      }

      it("how many moves?") {
        maze.jumpUntilOut()

        expect(maze.currentIndex) == 5
        expect(maze.toArray()) == [2, 5, 0, 1, -2]
        expect(maze.isOut) == true
        expect(maze.jumpCount) == 5
      }
    }

    describe("part 2") {
      var maze: AMazeOfTwistyTrampolines.Maze!

      beforeEach {
        maze = AMazeOfTwistyTrampolines.mazePartTwo([0, 3, 0, 1, -3])
      }

      it("how many moves?") {
        maze.jumpUntilOut()

        expect(maze.toArray()) == [2, 3, 2, 3, -1]
        expect(maze.isOut) == true
        expect(maze.jumpCount) == 10
      }
    }
  }
}

