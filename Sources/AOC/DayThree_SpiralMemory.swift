import Foundation

enum Direction {
  case up
  case down
  case left
  case right
}

struct Coordinate: Equatable, Hashable {
  let x: Int
  let y: Int

  func manhattanDistance(_ other: Coordinate) -> Int {
    return abs(self.x - other.x) + abs(self.y - other.y)
  }

  func increment(_ direction: Direction) -> Coordinate {
    switch direction {
    case .up:
      return Coordinate(x: x, y: y + 1)
    case .down:
      return Coordinate(x: x, y: y - 1)
    case .left:
      return Coordinate(x: x - 1, y: y)
    case .right:
      return Coordinate(x: x + 1, y: y)
    }
  }

  var hashValue: Int {
    return "\(x)\(y)".hashValue
  }

  public static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }
}

class Grid {
  typealias NumberToCoordinate = [Int: Coordinate]
  typealias CoordinateToNumber = [Coordinate: Int]

  var numbersToCoordinate = NumberToCoordinate()
  var coordinatesToNumber = CoordinateToNumber()

  init(number: Int, coordinate: Coordinate) {
    set(number: number, coordinate: coordinate)
  }

  func set(number: Int, coordinate: Coordinate) {
    coordinatesToNumber[coordinate] = number
    numbersToCoordinate[number] = coordinate
  }

  func get(_ number: Int) -> Coordinate? {
    return numbersToCoordinate[number]
  }

  func get(_ coordinate: Coordinate) -> Int? {
    return coordinatesToNumber[coordinate]
  }

  func allNearby(_ coordinate: Coordinate) -> [Int] {
    let above = coordinate.increment(.up)
    let below = coordinate.increment(.down)

    let coordinates = [
      above.increment(.left),
      above,
      above.increment(.right),

      coordinate.increment(.left),
      coordinate,
      coordinate.increment(.right),

      below.increment(.left),
      below,
      below.increment(.right),
    ]

    return coordinates.reduce(into: [Int](), { (numbers, coordinate) in
      if let number = self.get(coordinate) {
        numbers.append(number)
      }
    })
  }

  public static func initial() -> Grid {
    return Grid(number: 1, coordinate: Coordinate(x: 0, y: 0))
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

/*
 So, the first few squares' values are chosen as follows:

 Square 1 starts with the value 1.
 Square 2 has only one adjacent filled square (with value 1), so it also stores 1.
 Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.
 Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.
 Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.

 Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:

 147  142  133  122   59
 304    5    4    2   57
 330   10    1    1   54
 351   11   23   25   26
 362  747  806--->   ...
*/

public struct SpiralMemory {
  public static func moves(from: Int, to: Int) -> Int {
    let grid = walkGrid(done: { $0 == from }) { $0 + 1 }

    if let gridFrom = grid.get(from), let gridTo = grid.get(to) {
      return gridFrom.manhattanDistance(gridTo)
    } else {
      fatalError("Couldn't find \(from) or \(to) in \(grid.numbersToCoordinate)")
    }
  }

  public static func valueAt(_ index: Int) -> Int {
    var output = 1

    walkGrid(done: { idx, _coordinate, grid in
      index <= idx
    }, getNextNumber: { index, coordinate, grid in
      let nearbyNumbers = grid.allNearby(coordinate)

      output = nearbyNumbers.reduce(0, +)
      return output
    })

    return output
  }

  public static func firstValueLargerThan(_ numberLargerThan: Int) -> Int {
    var number = 0

    walkGrid(done: { idx, _coordinate, grid in
      number > numberLargerThan
    }, getNextNumber: { index, coordinate, grid in
      let nearbyNumbers = grid.allNearby(coordinate)

      number = nearbyNumbers.reduce(0, +)
      return number
    })

    return number
  }

  private static let nextGridDirections: [Direction: Direction] = [
    .right: .up,
    .up: .left,
    .left: .down,
    .down: .right,
  ]

  private static func walkGrid(done: (Int) -> Bool, getNextNumber: (Int) -> Int) -> Grid {
    return walkGrid(done: { (index, _coordinate, _grid) in
      done(index)
    }, getNextNumber: { (index, _coordinate, _grid) in
      getNextNumber(index)
    })
  }

  @discardableResult private static func walkGrid(done: (Int, Coordinate, Grid) -> Bool, getNextNumber: (Int, Coordinate, Grid) -> Int) -> Grid {
    let grid = Grid.initial()

    var direction = Direction.down
    var lastCoordinate = grid.get(1)!
    var number = 1
    var index = 1

    while !done(index, lastCoordinate, grid) {
      let nextDirection = nextGridDirections[direction]!
      let nextCoordinateInSameDirection = lastCoordinate.increment(direction)
      let nextCoordinateInNextDirection = lastCoordinate.increment(nextDirection)
      let anyInNextDirection = grid.get(nextCoordinateInNextDirection) != nil

      direction = anyInNextDirection ? direction : nextDirection
      let nextCoordinate = anyInNextDirection ? nextCoordinateInSameDirection : nextCoordinateInNextDirection

      number = getNextNumber(index, nextCoordinate, grid)
      grid.set(number: number, coordinate: nextCoordinate)
      lastCoordinate = nextCoordinate
      index += 1
    }

    return grid
  }
}

