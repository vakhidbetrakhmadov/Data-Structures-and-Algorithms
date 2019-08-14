import Foundation

public extension RandomAccessCollection where Element: Comparable {
    func binarySearchIterative(_ element: Element) -> Index? {
        var start = startIndex
        var end = index(before: endIndex)
        
        while start <= end {
            let middle = index(start, offsetBy: distance(from: start, to: end) / 2)
            
            if self[middle] == element {
                return middle
            } else if element < self[middle] {
                end = index(before: middle)
            } else {
                start = index(after: middle)
            }
        }
        
        return nil
    }
    
    func binarySearchRecursive(_ element: Element) -> Index? {
        func binarySearch(range: Range<Index>) -> Index? {
            guard range.lowerBound < range.upperBound else { return nil }
            
            let middle = index(range.lowerBound, offsetBy: distance(from: range.lowerBound, to: range.upperBound) / 2)
            
            if self[middle] == element {
                return middle
            } else if element < self[middle] {
                return binarySearch(range: range.lowerBound..<middle)
            } else {
                return binarySearch(range: index(after: middle)..<range.upperBound)
            }
        }
        
        return binarySearch(range: startIndex..<endIndex)
    }
}
