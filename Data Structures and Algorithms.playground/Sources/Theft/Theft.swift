import Foundation

public extension Algorithm {
    static func theft(field: [[Int]]) -> Int {
        let rows = field.count
        let cols = field[0].count
        
        var DPTable: [[Int]] = .init(repeating: .init(repeating: 0, count: cols), count: rows)
        
        func isValidCoordinate(row: Int, col: Int) -> Bool {
            return row >= 0 && col >= 0 && row < rows && col < cols
        }
        
        for col in (0..<cols) {
            for row in (0..<rows) {
                let leftUp = isValidCoordinate(row: row-1, col: col-1) ? DPTable[row-1][col-1] : 0
                let left = isValidCoordinate(row: row, col: col-1) ? DPTable[row][col-1] : 0
                let leftDown = isValidCoordinate(row: row+1, col: col-1) ? DPTable[row+1][col-1] : 0
                DPTable[row][col] = max(leftUp, left, leftDown) + field[row][col]
            }
        }
        
        return DPTable.compactMap { $0.last }.max() ?? 0
    }
}
