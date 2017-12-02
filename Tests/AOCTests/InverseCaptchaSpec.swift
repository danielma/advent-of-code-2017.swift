import Quick
import Nimble
@testable import AOC

class InverseCaptchaSpec: QuickSpec {
  override func spec() {
    describe("part 1") {
      it("1122") {
        expect(inverseCaptchaPart1("1122")).to(equal(3))
      }

      it("1111") {
        expect(inverseCaptchaPart1("1111")).to(equal(4))
      }

      it("1234") {
        expect(inverseCaptchaPart1("1234")).to(equal(0))
      }

      it("91212129") {
        expect(inverseCaptchaPart1("91212129")).to(equal(9))
      }
    }
  }
}
