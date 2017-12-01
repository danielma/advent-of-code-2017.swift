import Quick
import Nimble

class MySpec: QuickSpec {
  override func spec() {
    describe("the test suite") {
      it("runs my `it` block") {
        expect(true).to(beTruthy())
      }
    }
  }
}
