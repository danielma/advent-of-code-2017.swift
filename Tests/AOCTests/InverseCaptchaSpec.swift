import Quick
import Nimble
@testable import AOC

class InverseCaptchaSpec: QuickSpec {
  override func spec() {
    describe("explanatory examples") {
      it("1122") {
        expect(inverseCaptcha("1122")).to(equal(3))
      }

      it("1111") {
        expect(inverseCaptcha("1111")).to(equal(4))
      }

      it("1234") {
        expect(inverseCaptcha("1234")).to(equal(0))
      }

      it("91212129") {
        expect(inverseCaptcha("91212129")).to(equal(9))
      }
    }
  }
}
