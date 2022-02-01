@testable import BowlingTdd
import Quick
import Nimble

class BowlingTddTests: QuickSpec {
    override func spec() {
        var sut: Bowling!

        beforeEach {
            sut = BowlingGame(withPlayers: 2)
        }

        describe("getPlayerCount") {
            it("returns amountOfPlayers") {
                sut = BowlingGame(withPlayers: 1)
                expect(sut.getPlayerCount()).to(equal(1))

                sut = BowlingGame(withPlayers: 2)
                expect(sut.getPlayerCount()).to(equal(2))

                sut = BowlingGame(withPlayers: 3)
                expect(sut.getPlayerCount()).to(equal(3))
            }
        }
    }
}
