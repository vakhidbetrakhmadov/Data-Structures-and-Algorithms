import Foundation

// O(N log(N))
public extension Array where Element == Int {
    
    func minimumSubarray() -> (low: Index, high: Index, sum: Int) {
        
        func minimumCrossingSubarray(low: Index, mid: Index, high: Index) -> (low: Index, high: Index, sum: Int) {
            
            func minimumSumFromStart<C: BidirectionalCollection>(in range: C) -> (index: Index, sum: Int) where C.Element == Index {
                var sum = Int.max
                var index = range.first!
                
                var currentSum = 0
                for i in range {
                    currentSum += self[i]
                    
                    if currentSum < sum {
                        sum = currentSum
                        index = i
                    }
                }
                
                return (index, sum)
            }
            
            let left = minimumSumFromStart(in: (low...mid).reversed())
            let right = minimumSumFromStart(in: (index(after: mid))...high)
            
            return (left.index, right.index, left.sum + right.sum)
        }
        
        func msa(low: Index, high: Index) -> (low: Index, high: Index, sum: Int) {
            guard high > low else { return (low, high, self[low]) }
            
            let mid = index(low, offsetBy: distance(from: low, to: high) / 2)
            
            let left = msa(low: low, high: mid)
            let right = msa(low: index(after: mid), high: high)
            let crossing = minimumCrossingSubarray(low: low, mid: mid, high: high)
            
            var min = left
            
            if right.sum < min.sum {
                min = right
            }
            
            if crossing.sum < min.sum {
                min = crossing
            }
            
            return min
        }
        
        return msa(low: startIndex, high: index(before: endIndex))
    }
}
