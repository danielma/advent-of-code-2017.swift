import Foundation

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
    let relativeCoordinates = calculateSpiralRelativeCoordinates(from: from, to: to)
    return manhattanDistance(relativeCoordinates.0, relativeCoordinates.1)
  }

  public static func valueAt(_ index: Int) -> Int {
    var output = 1

    drawGrid(to: index, incrementGrid: { index, coordinate, grid in
      let nearbyNumbers = allNearby(coordinate, grid: grid)

      output = nearbyNumbers.reduce(0, +)
      return output
    })

    return output
  }

  public static func firstValueLargerThan(_ number: Int) -> Int {
    var output = 0
    drawGrid(toNumber: number + 1, incrementGrid: { index, coordinate, grid in
      let nearbyNumbers = allNearby(coordinate, grid: grid)

      output = nearbyNumbers.reduce(0, +)
      return output
    })

    return output
  }

  private static func allNearby(_ coordinate: Coordinate, grid: Grid) -> [Int] {
    let above = incrementCoordinate(coordinate, direction: .up)
    let below = incrementCoordinate(coordinate, direction: .down)

    let coordinates = [
      incrementCoordinate(above, direction: .left),
      above,
      incrementCoordinate(above, direction: .right),

      incrementCoordinate(coordinate, direction: .left),
      coordinate,
      incrementCoordinate(coordinate, direction: .right),

      incrementCoordinate(below, direction: .left),
      below,
      incrementCoordinate(below, direction: .right),
    ]

    return coordinates.reduce(into: [Int](), { (numbers, coordinate) in
      if let number = grid.get(coordinate) {
        numbers.append(number)
      }
    })
  }

  private static func manhattanDistance(_ a: Coordinate, _ b: Coordinate) -> Int {
    return abs(a.x - b.x) + abs(a.y - b.y)
  }

  private static func calculateSpiralRelativeCoordinates(from: Int, to: Int) -> (Coordinate, Coordinate) {
    let grid = drawGrid(to: from, incrementGrid: { index, _coordinate, _grid in
      index + 1
    })

    if let gridFrom = grid.get(from), let gridTo = grid.get(to) {
      return (gridFrom, gridTo)
    } else {
      fatalError("Couldn't find \(from) or \(to) in \(grid)")
    }
  }

  class Grid {
    typealias NumberToCoordinate = [Int: Coordinate]
    typealias CoordinateToNumber = [Coordinate: Int]

    var numbersToCoordinate = NumberToCoordinate()
    var coordinatesToNumber = CoordinateToNumber()

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
  }

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

  private static func drawGrid(toNumber: Int, incrementGrid: (Int, Coordinate, Grid) -> Int) -> Grid {
    let grid = Grid()
    grid.set(number: 1, coordinate: Coordinate(x: 0, y: 0))

    if (toNumber <= 1) {
      return grid
    }

    var direction = GridDirection.down
    var lastCoordinate = grid.get(1)!
    var number = 1
    var index = 0

    while number < toNumber {
      let nextDirection = nextGridDirections[direction]!
      let nextCoordinateInSameDirection = incrementCoordinate(lastCoordinate, direction: direction)
      let nextCoordinateInNextDirection = incrementCoordinate(lastCoordinate, direction: nextDirection)
      let anyInNextDirection = grid.get(nextCoordinateInNextDirection) != nil

      direction = anyInNextDirection ? direction : nextDirection
      let nextCoordinate = anyInNextDirection ? nextCoordinateInSameDirection : nextCoordinateInNextDirection

      number = incrementGrid(index, nextCoordinate, grid)
      grid.set(number: number, coordinate: nextCoordinate)
      lastCoordinate = nextCoordinate
      index += 1
    }

    return grid
  }

  private static func drawGrid(to: Int, incrementGrid: (Int, Coordinate, Grid) -> Int) -> Grid {
    let initialGrid = Grid()
    initialGrid.set(number: 1, coordinate: Coordinate(x: 0, y: 0))

    if (to <= 1) {
      return initialGrid
    }

    let range = (1...to)
    var direction = GridDirection.down
    var lastCoordinate = initialGrid.get(1)!

    return range.reduce(into: initialGrid) { grid, index in
      let nextDirection = nextGridDirections[direction]!
      let nextCoordinateInSameDirection = incrementCoordinate(lastCoordinate, direction: direction)
      let nextCoordinateInNextDirection = incrementCoordinate(lastCoordinate, direction: nextDirection)
      let anyInNextDirection = grid.get(nextCoordinateInNextDirection) != nil

      direction = anyInNextDirection ? direction : nextDirection
      let nextCoordinate = anyInNextDirection ? nextCoordinateInSameDirection : nextCoordinateInNextDirection

      let number = incrementGrid(index, nextCoordinate, grid)
      grid.set(number: number, coordinate: nextCoordinate)
      lastCoordinate = nextCoordinate
    }
  }

  private static func incrementCoordinate(_ coordinate: Coordinate, direction: GridDirection) -> Coordinate {
    switch direction {
    case .up:
      return Coordinate(x: coordinate.x, y: coordinate.y + 1)
    case .down:
      return Coordinate(x: coordinate.x, y: coordinate.y - 1)
    case .left:
      return Coordinate(x: coordinate.x - 1, y: coordinate.y)
    case .right:
      return Coordinate(x: coordinate.x + 1, y: coordinate.y)
    }
  }
}

