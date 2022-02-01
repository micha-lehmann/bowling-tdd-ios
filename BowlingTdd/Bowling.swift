public protocol Bowling {
    func getPlayerCount() -> Int
    func getScore(ofPlayer: Array.Index) -> Int?
}

public struct BowlingGame: Bowling {
    private let playerCount: Int
    private var scores: [Int]

    public init(withPlayers amount: Int) {
        playerCount = amount
        scores = Array(repeating: 0, count: playerCount)
    }

    public func getPlayerCount() -> Int {
        return playerCount
    }

    public func getScore(ofPlayer index: Array.Index) -> Int? {
        guard scores.indices.contains(index) else {return nil}

        return scores[index]
    }
}

