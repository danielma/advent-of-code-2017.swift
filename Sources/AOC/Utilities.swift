//
//  Utilities.swift
//  AOCPackageDescription
//
//  Created by Daniel Ma on 12/3/17.
//

import Foundation

extension Array {
  func forEachPair(_ body: @escaping ((Element, Element)) -> Void) {
    for (element, sibling) in pairs() {
      body((element, sibling))
    }
  }

  func reduceEachPair<Result>(_ initialResult: Result, transform: @escaping (Result, (Element, Element)) -> Result) -> Result {
    var result = initialResult

    forEachPair { (elements) in
      result = transform(result, elements)
    }

    return result
  }

  func pairs() -> ArrayPairsIterator<Element> {
    return ArrayPairsIterator(self)
  }
}

class ArrayPairsIterator<T>: Sequence, IteratorProtocol {
  var array: Array<T>
  var iterationIndex = 1

  init(_ array: Array<T>) {
    self.array = array
  }

  func next() -> (T, T)? {
    let indexToCompareToCount = iterationIndex + 1
    if array.count <= 1 {
      return nil
    } else {
      let pair = (array[0], array[iterationIndex])

      if array.count == indexToCompareToCount {
        iterationIndex = 1
        array.remove(at: 0)
      } else {
        iterationIndex += 1
      }

      return pair
    }
  }
}
