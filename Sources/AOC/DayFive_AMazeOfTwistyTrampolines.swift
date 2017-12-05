import Foundation

public struct AMazeOfTwistyTrampolines {
  /*
   For example, consider the following list of jump offsets:

   0
   3
   0
   1
   -3

   Positive jumps ("forward") move downward; negative jumps move upward. For legibility in this example, these offset values will be written all on one line, with the current instruction marked in parentheses. The following steps would be taken before an exit is found:

   (0) 3  0  1  -3  - before we have taken any steps.
   (1) 3  0  1  -3  - jump with offset 0 (that is, don't jump at all). Fortunately, the instruction is then incremented to 1.
   2 (3) 0  1  -3  - step forward because of the instruction we just modified. The first instruction is incremented again, now to 2.
   2  4  0  1 (-3) - jump all the way to the end; leave a 4 behind.
   2 (4) 0  1  -2  - go back to where we just were; increment -3 to -2.
   2  5  0  1  -2  - jump 4 steps forward, escaping the maze.

   In this example, the exit is reached in 5 steps.
   */
  public static func mazePartOne(_ array: Array<Maze.Jump>) -> Maze {
    return Maze(array) { _currentJumpValue in
      1
    }
  }

  public static func mazePartOne(fromString: String) -> Maze {
    return mazePartOne(fromString.split(separator: "\n").map { Int(String($0))! })
  }

  /*
   Now, the jumps are even stranger: after each jump, if the offset was three or more, instead decrease it by 1. Otherwise, increase it by 1 as before.

   Using this rule with the above example, the process now takes 10 steps, and the offset values after finding the exit are left as 2 3 2 3 -1.

   How many steps does it now take to reach the exit?
   */
  public static func mazePartTwo(_ array: Array<Maze.Jump>) -> Maze {
    return Maze(array) { $0 >= 3 ? -1 : 1 }
  }

  public static func mazePartTwo(fromString: String) -> Maze {
    return mazePartTwo(fromString.split(separator: "\n").map { Int(String($0))! })
  }

  public class Maze {
    public typealias Jump = Int

    public var jumpCount = 0
    public var currentIndex = 0

    internal var maze: Array<Jump>
    internal let changeForCurrentOffset: (Jump) -> Jump

    init(_ maze: Array<Jump>, changeForCurrentOffset: @escaping (Jump) -> Jump) {
      self.maze = maze
      self.changeForCurrentOffset = changeForCurrentOffset
    }

    var isOut: Bool {
      return currentIndex >= maze.endIndex
    }

    func jump() {
      let currentJumpValue = maze[currentIndex]
      maze[currentIndex] += changeForCurrentOffset(currentJumpValue)
      currentIndex += currentJumpValue
      jumpCount += 1
    }

    func jumpUntilOut() {
      while !isOut {
        jump()
      }
    }

    func toArray() -> Array<Jump> {
      return maze
    }
  }
}
