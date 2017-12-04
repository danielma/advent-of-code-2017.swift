typealias SpreadsheetRow = [Int]

public struct Spreadsheet {
  var rows: [SpreadsheetRow]

  private static let space = Character(" ")
  private static let tab = Character("\t")

  public static func parse(_ source: String) -> Spreadsheet {
    let space = Character(" ")
    let tab = Character("\t")
    let rows = source.split(separator: "\n")
      .map { (row) -> [Int] in
        row
          .split { $0 == space || $0 == tab }
          .map { Int(String($0))! }
      }

    return Spreadsheet(rows: rows)
  }

  /*
   The spreadsheet consists of rows of apparently-random numbers. To make sure the recovery process is on the right track, they need you to calculate the spreadsheet's checksum. For each row, determine the difference between the largest value and the smallest value; the checksum is the sum of all of these differences.

   For example, given the following spreadsheet:

   5 1 9 5
   7 5 3
   2 4 6 8

   The first row's largest and smallest values are 9 and 1, and their difference is 8.
   The second row's largest and smallest values are 7 and 3, and their difference is 4.
   The third row's difference is 6.

   In this example, the spreadsheet's checksum would be 8 + 4 + 6 = 18.

   */

  public static func checksum(_ sheet: Spreadsheet) -> Int {
    return sheet.rows.reduce(0) { (memo, row) in
      memo + row.max()! - row.min()!
    }
  }

  /*
  For example, given the following spreadsheet:
  
  5 9 2 8
  9 4 7 3
  3 8 6 5
  
  In the first row, the only two numbers that evenly divide are 8 and 2; the result of this division is 4.
  In the second row, the two numbers are 9 and 3; the result is 3.
  In the third row, the result is 2.
  
  In this example, the sum of the results would be 4 + 3 + 2 = 9.
  */

  public static func divisionChecksum(_ sheet: Spreadsheet) -> Int {
    return sheet.rows.reduce(0) { (memo, row) in
      memo + row.reduceEachPair(0) { (memo, pair) in
        let (intA, intB) = pair

        if intA % intB == 0 {
          return memo + (intA / intB)
        } else if intB % intA == 0 {
          return memo + (intB / intA)
        } else {
          return memo
        }
      }
    }
  }

}
