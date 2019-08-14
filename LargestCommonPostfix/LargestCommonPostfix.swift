import Foundation

public extension Array where Element == String {
    func largesCommonPostfix() -> String {
        
        func largesCommonPostfix(string1: String, string2: String) -> String {
            let slice1: Substring
            let slice2: Substring
            
            if string1.count < string2.count {
                let diff = string2.count - string1.count
                slice1 = string1[string1.startIndex...]
                slice2 = string2[string2.index(string2.startIndex, offsetBy: diff)...] // O(N)
            } else {
                let diff = string1.count - string2.count
                slice1 = string1[string1.index(string1.startIndex, offsetBy: diff)...] // O(N)
                slice2 = string2[string2.startIndex...]
            }
            
            for (i1, i2) in zip(slice1.indices, slice2.indices) {
                if slice1[i1...] == slice2[i2...] {
                    return String(slice1[i1...])
                }
            }
            
            return ""
        }
        
        func largesCommonPostfix(low: Index, high: Index) -> String {
            guard low < high else { return self[low] }
            
            let mid = index(low, offsetBy: distance(from: low, to: high) / 2)
            
            let left = largesCommonPostfix(low: low, high: mid)
            let right = largesCommonPostfix(low: index(after: mid), high: high)
            return largesCommonPostfix(string1: left, string2: right)
        }
        
        return largesCommonPostfix(low: startIndex, high: index(before: endIndex))
    }
}
