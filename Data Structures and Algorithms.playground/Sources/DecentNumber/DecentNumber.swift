import Foundation

public extension Algorithm {
    public static func decentNumber(size: Int) -> String? {
        guard size > 0 else { return "" }
        
        if size < 3 {
            return nil
        } else if size % 3 == 0 {
            return String(repeating: "555", count: size / 3)
        } else if size % 5 == 0 {
            return String(repeating: "33333", count: size / 5)
        } else {
            return decentNumber(size: size - 3).map { "555" + $0 }
        }
    }
}
