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
            beforeEach {
                sut = BowlingGame(withPlayers: 1)
            }

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

            context("after two rolls of 1") {
                beforeEach {
                    sut.roll(knockOver: 1)
                    sut.roll(knockOver: 1)
                }

                it("returns 2") {
                    expect(sut.getScore(ofPlayer: 0)).to(equal(2))
                }
            }

            context("after one strike") {
                var score: Int!

                beforeEach {
                    sut.roll(knockOver: sut.pinCount)

                    score = sut.getScore(ofPlayer: 0)
                }

                it("returns pinCount") {
                    expect(sut.getScore(ofPlayer: 0)).to(equal(sut.pinCount))
                }

                it("doubles the next roll") {
                    sut.roll(knockOver: 1)

                    expect(sut.getScore(ofPlayer: 0)).to(equal(score + 2))
                }

                it("doubles the next two rolls") {
                    sut.roll(knockOver: 1)
                    sut.roll(knockOver: 1)

                    expect(sut.getScore(ofPlayer: 0)).to(equal(score + 4))
                }
            }

            context("after two strikes") {
                var score: Int!

                beforeEach {
                    sut.roll(knockOver: sut.pinCount)
                    sut.roll(knockOver: sut.pinCount)

                    score = sut.getScore(ofPlayer: 0)
                }

                it("returns pinCount * 3") {
                    expect(sut.getScore(ofPlayer: 0)).to(equal(sut.pinCount * 3))
                }

                it("triples the next roll") {
                    sut.roll(knockOver: 1)

                    expect(sut.getScore(ofPlayer: 0)).to(equal(score + 3))
                }
            }

            context("after three strikes") {
                var score: Int!

                beforeEach {
                    sut.roll(knockOver: sut.pinCount)
                    sut.roll(knockOver: sut.pinCount)
                    sut.roll(knockOver: sut.pinCount)

                    score = sut.getScore(ofPlayer: 0)
                }

                it("returns pinCount * 6") {
                    expect(sut.getScore(ofPlayer: 0)).to(equal(sut.pinCount * 6))
                }

                it("triples the next roll") {
                    sut.roll(knockOver: 1)

                    expect(sut.getScore(ofPlayer: 0)).to(equal(score + 3))
                }
            }

            context("after one spare") {
                var score: Int!

                beforeEach {
                    sut.roll(knockOver: sut.pinCount - 4)
                    sut.roll(knockOver: 4)

                    score = sut.getScore(ofPlayer: 0)
                }

                it("returns pinCount") {
                    expect(sut.getScore(ofPlayer: 0)).to(equal(sut.pinCount))
                }

                it("doubles the next roll") {
                    sut.roll(knockOver: 1)

                    expect(sut.getScore(ofPlayer: 0)).to(equal(score + 2))
                }

                it("does not double the next next roll") {
                    sut.roll(knockOver: 1)

                    score = sut.getScore(ofPlayer: 0)

                    sut.roll(knockOver: 1)

                    expect(sut.getScore(ofPlayer: 0)).to(equal(score + 1))
                }
            }

            context("after two spares") {
                var score: Int!

                beforeEach {
                    for _ in 1...2 {
                        sut.roll(knockOver: sut.pinCount - 2)
                        sut.roll(knockOver: 2)
                    }

                    score = sut.getScore(ofPlayer: 0)
                }

                it("doubles the next roll") {
                    sut.roll(knockOver: 1)

                    expect(sut.getScore(ofPlayer: 0)).to(equal(score + 2))
                }

                it("does not double the next next roll") {
                    sut.roll(knockOver: 1)

                    score = sut.getScore(ofPlayer: 0)

                    sut.roll(knockOver: 1)

                    expect(sut.getScore(ofPlayer: 0)).to(equal(score + 1))
                }
            }
        }
    }
}
