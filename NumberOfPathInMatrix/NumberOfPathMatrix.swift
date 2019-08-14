import Foundation

public func numberOfPaths(rows: Int, cols: Int, available: [[Bool]]) -> Int {
    let lastRow = rows - 1
    let lastCol = cols - 1
    
    func numberOfPaths(row: Int, col: Int) -> Int {
        guard row < rows && col < cols && available[row][col] else { return 0 }
        
        if row == lastRow && col == lastCol {
            return 1
        }
        
        return numberOfPaths(row: row + 1, col: col) + numberOfPaths(row: row, col: col + 1)
    }
    
    return numberOfPaths(row: 0, col: 0)
}

public func numberOfPathsDinamic(rows: Int, cols: Int, available: [[Bool]]) -> Int {
    let lastRow = rows - 1
    let lastCol = cols - 1
    
    var table = Array(repeating: Array(repeating: -1, count: cols), count: rows)
    
    func numberOfPaths(row: Int, col: Int) -> Int {
        guard row < rows && col < cols && available[row][col] else { return 0 }
        
        if row == lastRow && col == lastCol {
            return 1
        }
        
        if table[row][col] == -1 {
            table[row][col] = numberOfPaths(row: row + 1, col: col) + numberOfPaths(row: row, col: col + 1)
        }
        
        return table[row][col]
    }
    
    return numberOfPaths(row: 0, col: 0)
}
