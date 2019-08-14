import Foundation

// MARK: - Node

public final class Node<Value>: NodeProtocol {
    
    // MARK: - Properties
    
    public internal(set) var value: Value
    public internal(set) var next: Node<Value>?
    
    // MARK: - Inits & deinit
    
    public init(value: Value, next: Node<Value>? = nil) {
        self.value = value
        self.next = next
    }
}


// MARK: - DoubleNode

public final class DoubleNode<Value>: DoubleNodeProtocol {
    
    // MARK: - Properties
    
    public internal(set) var value: Value
    public internal(set) var next: DoubleNode<Value>?
    public internal(set) var previous: DoubleNode<Value>?
    
    // MARK: - Inits & deinit
    
    public init(value: Value, next: DoubleNode<Value>? = nil, previous: DoubleNode<Value>? = nil) {
        self.value = value
        self.next = next
        self.previous = previous
    }
}
