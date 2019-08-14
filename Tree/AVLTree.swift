import Foundation

// TODO: Make AVLTree to conform to BinarySeachTreeProtocol

public struct AVLTree<T> where T: Hashable, T: Comparable {
    public typealias Node = AVLTreeNode<T>
    
    public var root: Node?
    
    public init(root: Node? = nil) {
        self.root = root
    }
    
    public func containsRecursive(_ value: T) -> Bool {
        func contains(node: Node?, value: T) -> Bool {
            guard let node = node else { return false }
            
            if node.value == value {
                return true
            }
            
            return (value < node.value)
                ? contains(node: node.leftChild, value: value)
                : contains(node: node.rightChild, value: value)
        }
        
        return contains(node: root, value: value)
    }
    
    public func containsInterative(_ value: T) -> Bool {
        var next = root
        
        while let current = next {
            
            if current.value == value {
                return true
            }
            
            if value < current.value {
                next = current.leftChild
            } else {
                next = current.rightChild
            }
        }
        
        return false
    }
    
    public mutating func insert(_ value: T) {
        func insert(node: Node?, value: T) -> Node {
            guard let node = node else { return Node(value: value) }
            
            if value < node.value {
                node.leftChild = insert(node: node.leftChild, value: value)
            } else {
                node.rightChild = insert(node: node.rightChild, value: value)
            }
            
            let balancedNode = balance(node: node)
            balancedNode.height = max(balancedNode.leftChildHeight, balancedNode.rightChildHeight) + 1
            
            return balancedNode
        }
        
        root = insert(node: root, value: value)
    }
    
    public mutating func remove(_ value: T) {
        func min(node: Node) -> T {
            return node.leftChild.map(min) ?? node.value
        }
        
        func remove(node: Node?, value: T) -> Node? {
            guard let node = node else { return nil }
            
            if node.value == value {
                
                if (node.leftChild, node.rightChild) == (nil, nil) {
                    return nil
                } else if node.leftChild == nil {
                    return node.rightChild
                } else if node.rightChild == nil {
                    return node.leftChild
                } else {
                    node.value = min(node: node.rightChild!)
                    node.rightChild = remove(node: node.rightChild, value: node.value)
                }
                
            } else if value < node.value {
                node.leftChild = remove(node: node.leftChild, value: value)
            } else {
                node.rightChild = remove(node: node.rightChild, value: value)
            }
            
            let balancedNode = balance(node: node)
            balancedNode.height = max(balancedNode.leftChildHeight, balancedNode.rightChildHeight) + 1
            
            return balancedNode
        }
        
        root = remove(node: root, value: value)
    }
    
    private func rotateLeft(around node: Node) -> Node {
        let pivot = node.rightChild!
        
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        
        node.height = max(node.leftChildHeight, node.rightChildHeight) + 1
        pivot.height = max(pivot.leftChildHeight, pivot.leftChildHeight) + 1
        
        return pivot
    }
    
    private func rotateRight(around node: Node) -> Node {
        let pivot = node.leftChild!
        
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        
        node.height = max(node.leftChildHeight, node.rightChildHeight) + 1
        pivot.height = max(pivot.leftChildHeight, pivot.leftChildHeight) + 1
        
        return pivot
    }
    
    private func rotateLeftRight(around node: Node) -> Node {
        guard let leftChild = node.leftChild else { return node }
        
        node.leftChild = rotateLeft(around: leftChild)
        return rotateRight(around: node)
    }
    
    private func rotateRightLeft(around node: Node) -> Node {
        guard let rightChild = node.rightChild else { return node }
        
        node.rightChild = rotateRight(around: rightChild)
        return rotateLeft(around: node)
    }
    
    private func balance(node: Node) -> Node {
        switch node.balance {
        case -2:
            if node.rightChild?.balance == -1 {
                return rotateLeft(around: node)
            } else {
                return rotateRightLeft(around: node)
            }
        case 2:
            if node.rightChild?.balance == 1 {
                return rotateRight(around: node)
            } else {
                return rotateLeftRight(around: node)
            }
        default:
            return node
        }
    }
}
