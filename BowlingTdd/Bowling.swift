public protocol Bowling {
    func getPlayerCount() -> Int
    func getScore(ofPlayer: Array.Index) -> Int?
    mutating func roll(knockOver: Int)

    var pinCount: Int {get}
    var frameCount: Int {get}
}

public struct BowlingGame: Bowling {
    public init(withPlayers amount: Int) {
        playerCount = amount
        scores = Array(repeating: 0, count: playerCount)
        doubledRolls = Array(repeating: 0, count: playerCount)
        tripledRolls = Array(repeating: 0, count: playerCount)
        pinsRemaining = pinCount
    }

    public func getPlayerCount() -> Int {
        return playerCount
    }

    public func getScore(ofPlayer index: Array.Index) -> Int? {
        guard scores.indices.contains(index) else {return nil}

        return scores[index]
    }

    public mutating func roll(knockOver amount: Int) {
        scores[0] += amount

        pinsRemaining -= amount

        doDoubledRolls(knockedOver: amount)
        doTripledRolls(knockedOver: amount)

        if isClear() {
            handleClearing(amount)
        }
    }


    private mutating func doDoubledRolls(knockedOver amount: Int) {
        if doubledRolls[0] > 0 {
            scores[0] += amount

            doubledRolls[0] -= 1
        }
    }

    private mutating func doTripledRolls(knockedOver amount: Int) {
        if tripledRolls[0] > 0 {
            scores[0] += amount

            tripledRolls[0] -= 1
        }
    }

    private func isClear() -> Bool {
        return pinsRemaining == 0
    }

    private mutating func handleClearing(_ amount: Int) {
        if isStrike(amount) {
            handleStrike()
        } else {
            handleSpare()
        }

        resetPins()
    }

    private mutating func handleStrike() {
        if doubledRolls[0] == 1 {
            tripledRolls[0] = 1
        }

        doubledRolls[0] = 2
    }

    private mutating func handleSpare() {
        doubledRolls[0] = 1
    }

    private func isStrike(_ amount: Int) -> Bool {
        return amount == pinCount
    }

    private mutating func resetPins() {
        pinsRemaining = pinCount
    }

    private let playerCount: Int
    private var scores: [Int]
    private var doubledRolls: [Int]
    private var tripledRolls: [Int]
    private var pinsRemaining: Int

    public let pinCount = 10
    public let frameCount = 10
}

