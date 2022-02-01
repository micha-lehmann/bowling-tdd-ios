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

        describe("getScore") {
            context("when index is invalid") {
                it("returns nil") {
                    expect(sut.getScore(ofPlayer: -1)).to(beNil())
                    expect(sut.getScore(ofPlayer: 1000)).to(beNil())
                }
            }

            context("before any rolls") {
                it("returns 0") {
                    expect(sut.getScore(ofPlayer: 0)).to(equal(0))
                }
            }

            context("after one roll of 1") {
                beforeEach {
                    sut.roll(knockOver: 1)
                }

                it("returns 1") {
                    expect(sut.getScore(ofPlayer: 0)).to(equal(1))
                }
            }
        }
    }
}
