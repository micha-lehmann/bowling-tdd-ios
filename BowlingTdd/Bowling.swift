public protocol Bowling {
    func getPlayerCount() -> Int
}

public struct BowlingGame: Bowling {
    private let playerCount: Int

    public init(withPlayers amount: Int) {
        playerCount = amount
    }

    public func getPlayerCount() -> Int {
        return playerCount
    }
}

