import Foundation

public struct LinkedList<Value>: LinkedListProtocol {
    
    // MARK: - Properties
    
    public private(set) var head: Node<Value>?
    
    public private(set) var tail: Node<Value>?
    
    public private(set) var count: Int
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    // MARK: - Inits & deinit
    
    public init() {
        self.count = 0
    }
    
    // MARK: - Methods
    
    // Time complexity: O(1)
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        count += 1
        
        if tail == nil {
            tail = head
        }
    }
    
    // O(1)
    public mutating func append( _ value: Value) {
        guard !isEmpty else { return push(value) }
        
        tail?.next = Node(value: value)
        tail = tail?.next
        count += 1
    }
    
    // O(1)
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        node.next = Node(value: value, next: node.next)
        count += 1
        
        if node === tail {
            tail = node.next
        }
        
        return node.next!
    }
    
    // O(1)
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            count -= 1
            
            if head == nil {
                tail = nil
                count = 0
            }
        }
        return head?.value
    }
    
    // O(N)
    public mutating func removeLast() -> Value? {
        guard count > 1 else { return pop() }
        
        let lastButOne = sequence(first: head, next: { $0?.next }).first(where: { $0?.next === tail }).flatMap { $0 }
        defer {
            lastButOne?.next = nil
            tail = lastButOne
            count -= 1
        }
        return tail?.value
    }
    
    // O(1)
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            count -= (node.next != nil) ? 1 : 0
            node.next = node.next?.next
            if node.next == nil {
                tail = node
            }
        }
        return node.next?.value
    }
    
    // Best: O(1)
    // Worst: O(N)
    public func node(at index: Int) -> Node<Value>? {
        guard index != count - 1 else { return tail }
        return sequence(first: head, next: { $0?.next }).enumerated().first(where: { $0.offset == index })?.element
    }
}

extension LinkedList: Collection {
    public struct Index: Equatable, Comparable {
        fileprivate let node: Node<Value>?

        public static func == (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?): return left === right
            case (nil, nil): return true
            default: return false
            }
        }

        public static func < (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            guard lhs != rhs else  { return false }
            return !sequence(first: rhs.node, next: { $0?.next }).contains(where: { $0 === lhs.node })
        }
    }

    public var startIndex: Index {
        return Index(node: head)
    }

    public var endIndex: Index {
        return Index(node: tail?.next)
    }

    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }

    public subscript(index: Index) -> Value {
        get {
            return index.node!.value
        }
        set {
            index.node!.value = newValue
        }
    }
}
