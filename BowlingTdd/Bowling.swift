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
        doubledThrows = Array(repeating: 0, count: playerCount)
        tripledThrows = Array(repeating: 0, count: playerCount)
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

        doDoubledThrows(knockedOver: amount)
        doTripledThrows(knockedOver: amount)

        if isStrike(amount) {
            if doubledThrows[0] == 1 {
                tripledThrows[0] = 1
            }

            doubledThrows[0] = 2
        } // TODO: else if isSpare(amount)
    }


    private mutating func doDoubledThrows(knockedOver amount: Int) {
        if doubledThrows[0] > 0 {
            scores[0] += amount

            doubledThrows[0] -= 1
        }
    }

    private mutating func doTripledThrows(knockedOver amount: Int) {
        if tripledThrows[0] > 0 {
            scores[0] += amount

            tripledThrows[0] -= 1
        }
    }

    private func isStrike(_ amount: Int) -> Bool {
        return amount == 10
    }

    private let playerCount: Int
    private var scores: [Int]
    private var doubledThrows: [Int]
    private var tripledThrows: [Int]

    public let pinCount = 10
    public let frameCount = 10
}

