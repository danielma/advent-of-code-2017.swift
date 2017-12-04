import Quick
import Nimble
@testable import AOC

class DayFour_HighEntropyPassphrasesSpec: QuickSpec {
  override func spec() {
    fdescribe("part 1") {
      it("aa bb cc dd ee") {
        expect(HighEntropyPassphrases.isValid("aa bb cc dd ee")) == true
      }

      it("aa bb cc dd aa") {
        expect(HighEntropyPassphrases.isValid("aa bb cc dd aa")) == false
      }

      it("aa bb cc dd aaa") {
        expect(HighEntropyPassphrases.isValid("aa bb cc dd aaa")) == true
      }
    }
  }
}

