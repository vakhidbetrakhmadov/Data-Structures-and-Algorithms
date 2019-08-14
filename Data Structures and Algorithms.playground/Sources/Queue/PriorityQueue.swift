import Foundation

public struct PriorityQueue<T>: QueueProtocol {
    public typealias Comparator = Heap<T>.Comparator
    
    private var heap: Heap<T>
    
    public init(comparator: @escaping Comparator) {
        heap = Heap(comparator: comparator)
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public mutating func enqueue(value: T) {
        heap.insert(value: value)
    }
    
    @discardableResult
    public mutating func dequeue() -> T? {
        return heap.remove()
    }
    
    public func peek() -> T? {
        return heap.peek()
    }
}
