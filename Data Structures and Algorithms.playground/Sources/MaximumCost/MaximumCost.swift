import Foundation

public extension Algorithm  {
    static func maximumCost(Y: [Int]) -> Int {
        func maximumCost(at i: Int) -> (one: Int, self: Int) {
            guard i > 0 else { return (0, 0) }
            
            let iPrevious = maximumCost(at: i-1)
            
            let iCurrentOne = max(abs(1 - 1) + iPrevious.one, abs(1 - Y[i-1]) + iPrevious.`self`)
            
            let iCurrentSelf = max(abs(Y[i] - 1) + iPrevious.one, abs(Y[i] - Y[i-1]) + iPrevious.`self`)
            
            return (iCurrentOne, iCurrentSelf)
        }
        
        let (nOne, nSelf) = maximumCost(at: Y.endIndex-1)
        
        return max(nOne, nSelf)
    }
}

