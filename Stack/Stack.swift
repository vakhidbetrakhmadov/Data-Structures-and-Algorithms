import Foundation

public struct Stack<V> {
    
    public init() { }
    
    public init<S: Sequence>(_ sequence: S) where S.Element == V {
        sequence.forEach {
            push(value: $0)
        }
    }
    
    private var container: [V] = []
    
    public var isEmpty: Bool {
        return container.isEmpty
    }
    
    public var count: Int {
        return container.count
    }
    
    public mutating func push(value: V) {
        container.append(value)
    }
    
    @discardableResult
    public mutating func pop() -> V {
        return container.removeLast()
    }
    
    public func peek() -> V? {
        return container.last
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        return "top -> " + container.description
    }
}
