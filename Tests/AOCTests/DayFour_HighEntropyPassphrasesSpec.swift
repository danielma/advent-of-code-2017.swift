import Quick
import Nimble
@testable import AOC

class DayFour_HighEntropyPassphrasesSpec: QuickSpec {
  override func spec() {
    describe("part 1") {
      it("aa bb cc dd ee") {
        expect(HighEntropyPassphrases.isValidPartOne("aa bb cc dd ee")) == true
      }

      it("aa bb cc dd aa") {
        expect(HighEntropyPassphrases.isValidPartOne("aa bb cc dd aa")) == false
      }

      it("aa bb cc dd aaa") {
        expect(HighEntropyPassphrases.isValidPartOne("aa bb cc dd aaa")) == true
      }
    }

    describe("part 2") {
      it("abcde fghij") {
        expect(HighEntropyPassphrases.isValidPartTwo("abcde fghij")) == true
      }

      it("abcde xyz ecdab") {
        expect(HighEntropyPassphrases.isValidPartTwo("abcde xyz ecdab")) == false
      }

      it("a ab abc abd abf abj") {
        expect(HighEntropyPassphrases.isValidPartTwo("a ab abc abd abf abj")) == true
      }

      it("iiii oiii ooii oooi oooo") {
        expect(HighEntropyPassphrases.isValidPartTwo("iiii oiii ooii oooi oooo")) == true
      }

      it("oiii ioii iioi iiio") {
        expect(HighEntropyPassphrases.isValidPartTwo("oiii ioii iioi iiio")) == false
      }
    }
  }
}

