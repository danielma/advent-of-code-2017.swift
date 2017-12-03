import Foundation


extension Dictionary where Value: Equatable {
  func allKeys(forValue val: Value) -> [Key] {
    return self.filter { $1 == val }.map { $0.0 }
  }
}

struct Coordinate {
  let x: Int
  let y: Int
}

extension Coordinate: Equatable {}

func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y
}

extension Coordinate: Hashable {
  var hashValue: Int {
    return "\(x)\(y)".hashValue
  }
}

/*
 17  16  15  14  13
 18   5   4   3  12
 19   6   1   2  11
 20   7   8   9  10
 21  22  23---> ...

 While this is very space-efficient (no squares are skipped), requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.

 For example:

 Data from square 1 is carried 0 steps, since it's at the access port.
 Data from square 12 is carried 3 steps, such as: down, left, left.
 Data from square 23 is carried only 2 steps: up twice.
 Data from square 1024 must be carried 31 steps.
*/

public struct SpiralMemory {
  public static func moves(from: Int, to: Int) -> Int {
    let relativeCoordinates = calculateSpiralRelativeCoordinates(from: from, to: to)
    return manhattanDistance(relativeCoordinates.0, relativeCoordinates.1)
  }

  private static func manhattanDistance(_ a: Coordinate, _ b: Coordinate) -> Int {
    return abs(a.x - b.x) + abs(a.y - b.y)
  }

  private static func calculateSpiralRelativeCoordinates(from: Int, to: Int) -> (Coordinate, Coordinate) {
    let grid = drawGrid(to: from)

    if let gridFrom = grid[from], let gridTo = grid[to] {
      return (gridFrom, gridTo)
    } else {
      fatalError("Couldn't find \(from) or \(to) in \(grid)")
    }
  }

  typealias Grid = [Int: Coordinate]

  enum GridDirection {
    case up
    case down
    case left
    case right
  }

  private static let nextGridDirections: [GridDirection: GridDirection] = [
    .right: .up,
    .up: .left,
    .left: .down,
    .down: .right,
  ]

  private static func drawGrid(to: Int) -> Grid {
    if (to == 1) {
      return [1: Coordinate(x: 0, y: 0)]
    }

    let range = (2...to)
    var direction = GridDirection.down
    let numberToCoordinates = [1: Coordinate(x: 0, y: 0)]
    var coordinatesToNumbers: [Coordinate: Int] = [Coordinate(x: 0, y: 0): 1]

    return range.reduce(into: numberToCoordinates) { memo, number in
      let lastCoordinate = memo[number - 1]!
      let nextDirection = nextGridDirections[direction]!
      let nextCoordinateInSameDirection = incrementCoordinate(lastCoordinate, direction: direction)
      let nextCoordinateInNextDirection = incrementCoordinate(lastCoordinate, direction: nextDirection)
      let anyInNextDirection = coordinatesToNumbers[nextCoordinateInNextDirection] != nil

      if anyInNextDirection {
        coordinatesToNumbers[nextCoordinateInSameDirection] = number
        memo[number] = nextCoordinateInSameDirection
      } else {
        direction = nextDirection
        coordinatesToNumbers[nextCoordinateInNextDirection] = number
        memo[number] = nextCoordinateInNextDirection
      }
    }
  }

  private static func incrementCoordinate(_ coordinate: Coordinate, direction: GridDirection) -> Coordinate {
    switch direction {
    case .up:
      return Coordinate(x: coordinate.x, y: coordinate.y - 1)
    case .down:
      return Coordinate(x: coordinate.x, y: coordinate.y + 1)
    case .left:
      return Coordinate(x: coordinate.x - 1, y: coordinate.y)
    case .right:
      return Coordinate(x: coordinate.x + 1, y: coordinate.y)
    }
  }
}

