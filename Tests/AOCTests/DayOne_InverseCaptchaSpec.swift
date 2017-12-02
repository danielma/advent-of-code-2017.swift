import Quick
import Nimble
@testable import AOC

class DayOne_InverseCaptchaSpec: QuickSpec {
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

    describe("part 2") {
      it("1212") {
        expect(inverseCaptchaPart2("1212")).to(equal(6))
      }

      it("1221") {
        expect(inverseCaptchaPart2("1221")).to(equal(0))
      }

      it("123425") {
        expect(inverseCaptchaPart2("123425")).to(equal(4))
      }

      it("123123") {
        expect(inverseCaptchaPart2("123123")).to(equal(12))
      }

      it("12131415") {
        expect(inverseCaptchaPart2("12131415")).to(equal(4))
      }
    }
  }
}
