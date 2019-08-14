import Foundation

public struct Heap<T> {
    public typealias Comparator = (T, T) -> Bool
    
    public var container: [T] = []
    public let comparator: Comparator
    
    public init(comparator: @escaping Comparator) {
        self.comparator = comparator
    }
    
    public init<S: Sequence>(_ sequence: S, comparator: @escaping Comparator) where S.Element == T {
        self.comparator = comparator
        self.container = Array(sequence)
        
        if !isEmpty {
            for index in stride(from: count / 2 - 1, through: 0, by: -1) {
                siftDown(at: index)
            }
        }
    }
    
    public var isEmpty: Bool {
        return container.isEmpty
    }
    
    public var count: Int {
        return container.count
    }
    
    public func peek() -> T? {
        return container.first
    }
    
    public mutating func remove() -> T? {
        return remove(at: 0)
    }
    
    public mutating func insert(value: T) {
        container.append(value)
        siftUp(at: count - 1)
    }
    
    public mutating func remove(at index: Int) -> T? {
        guard index < count else { return nil }
        
        if index == count - 1 {
            return container.removeLast()
        } else {
            container.swapAt(index, count - 1)
            defer {
                siftDown(at: index)
                siftUp(at: index)
            }
            return container.removeLast()
        }
    }
    
    private func leftChild(of parent: Int) -> Int {
        return parent * 2 + 1
    }
    
    private func rightChild(of parent: Int) -> Int {
        return parent * 2 + 2
    }
    
    private func parent(of child: Int) -> Int {
        return (child - 1) / 2
    }
    
    public mutating func siftDown(at index: Int, upTo count: Int) {
        var parent = index
        
        while true {
            let left = self.leftChild(of: parent)
            let right = self.rightChild(of: parent)
            
            var candidate = parent
            
            if left < count && comparator(container[left], container[candidate]) {
                candidate = left
            }
            
            if right < count && comparator(container[right], container[candidate]) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            
            container.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    private mutating func siftDown(at index: Int) {
        siftDown(at: index, upTo: count)
    }
    
    private mutating func siftUp(at index: Int) {
        var child = index
        var parent = self.parent(of: child)
        
        while child > 0 && comparator(container[child], container[parent]) {
            container.swapAt(child, parent)
            child = parent
            parent = self.parent(of: child)
        }
    }
}
