import Foundation

public struct Queue<T>: QueueProtocol {
    
    // MARK: - Properties
    
    private var buffer = [T?](repeating: nil, count: 10)
    private var head = 0
    private var tail = 0
    
    private var isFull: Bool {
        return head == tail && buffer[tail] != nil
    }
    
    public var isEmpty: Bool {
        return head == tail && buffer[tail] == nil
    }
    
    // MARK: - Inits & deinit
    
    public init() { }
    
    public init<S: Sequence>(_ sequence: S) where S.Element == T {
        sequence.forEach {
            enqueue(value: $0)
        }
    }
    
    // MARK: - Methods
    
    public mutating func enqueue(value: T) {
        if isFull {
            resize()
        }
        
        buffer[tail] = value
        tail = (tail + 1) % buffer.count
    }
    
    public mutating func dequeue() -> T? {
        defer {
            buffer[head] = nil
            head = (head + 1) % buffer.count
        }
        return buffer[head]
    }
    
    public func peek() -> T? {
        return buffer[head]
    }
    
    private mutating func resize() {
        let count = buffer.count
        let prefix = buffer.prefix(head)
        let suffix = buffer.suffix(count - head)
        buffer = suffix + prefix + [T?](repeating: nil, count: count)
        head = 0
        tail = count
    }
}
