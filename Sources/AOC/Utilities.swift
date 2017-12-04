//
//  Utilities.swift
//  AOCPackageDescription
//
//  Created by Daniel Ma on 12/3/17.
//

import Foundation

extension Array {
  func forEachPair(_ body: @escaping ((Element, Element)) -> Void) {
    enumerated().forEach { (arg) in
      let (index, element) = arg
      let nextIndex = index + 1

      self[nextIndex...].forEach { (comparingElement) in
        body((element, comparingElement))
      }
    }
  }

  func reduceEachPair<Result>(_ initialResult: Result, transform: @escaping (Result, (Element, Element)) -> Result) -> Result {
    var result = initialResult

    forEachPair { (elements) in
      result = transform(result, elements)
    }

    return result
  }
}
