import Foundation

public struct RecursiveCircus {
  /*
   For example, if your list is the following:

   pbga (66)
   xhth (57)
   ebii (61)
   havc (66)
   ktlj (57)
   fwft (72) -> ktlj, cntj, xhth
   qoyq (66)
   padx (45) -> pbga, havc, qoyq
   tknk (41) -> ugml, padx, fwft
   jptl (61)
   ugml (68) -> gyxo, ebii, jptl
   gyxo (61)
   cntj (57)

   ...then you would be able to recreate the structure of the towers that looks like this:


                  gyxo
                /     
           ugml - ebii
         /      \     
        |         jptl
        |        
        |         pbga
       /        /
  tknk --- padx - havc
       \        \
        |         qoyq
        |             
        |         ktlj
         \      /     
           fwft - cntj
                \     
                  xhth

   In this example, tknk is at the bottom of the tower (the bottom program),
 */

  public struct Node {
    let name: String
    let weight: Int
    var nodes: [Node]

    init(_ name: String, weight: Int, nodes: [Node] = []) {
      self.name = name
      self.weight = weight
      self.nodes = nodes
    }

    private static let lineRegex = try! NSRegularExpression(
      pattern: "\\b([a-z]+) \\(([0-9]+)\\)",
      options: []
    )

    private static let lineHolderRegex = try! NSRegularExpression(
      pattern: "\\b([a-z]+).+ -> (.+)\\b",
      options: []
    )

    init(fromString string: String) {
      let lines = string.split(separator: "\n")
      let nodes = lines.reduce(into: [String: Node]()) { memo, line in
        let stringLine = String(line)
        let matches = Node.lineRegex.matches(
          in: stringLine,
          options: [],
          range: NSRange(location: 0, length: stringLine.count)
        )

        guard let match = matches.first,
          let nameRange = Range(match.range(at: 1), in: stringLine),
          let weightRange = Range(match.range(at: 2), in: stringLine) else {
          fatalError("can't parse \(stringLine)")
        }

        let name = String(stringLine[nameRange])

        memo[name] = Node(name, weight: Int(String(stringLine[weightRange]))!)
      }

      let parentNodes = lines.reduce(into: [String: Node]()) { memo, line in
        let stringLine = String(line)
        let  matches = Node.lineHolderRegex.matches(
          in: stringLine,
          options: [],
          range: NSRange(location: 0, length: stringLine.count)
        )

        if let match = matches.first,
          let nameRange = Range(match.range(at: 1), in: stringLine),
          let childrenRange = Range(match.range(at: 2), in: stringLine) {

          let name = String(stringLine[nameRange])

          memo[name] =
        }
      }
      print(nodes)
      self.init("hi", weight: 100)
    }
  }
}
