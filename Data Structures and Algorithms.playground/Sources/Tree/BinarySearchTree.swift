import Foundation

// TODO: Create BinarySeachTreeProtocol and make BinarySearchTree conform to it


public struct BinarySearchTree<T>: BinaryTreeProtocol where T: Hashable, T: Comparable {
    
    public var root: BinaryTreeNode<T>?
    
    public init(root: BinaryTreeNode<T>? = nil) {
        self.root = root
    }
    
    public func containsRecursive(_ value: T) -> Bool {
        func contains(node: BinaryTreeNode<T>?, value: T) -> Bool {
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
        func insert(node: BinaryTreeNode<T>?, value: T) -> BinaryTreeNode<T> {
            guard let node = node else { return BinaryTreeNode(value: value) }
            
            if value < node.value {
                node.leftChild = insert(node: node.leftChild, value: value)
            } else {
                node.rightChild = insert(node: node.rightChild, value: value)
            }
            
            return node
        }
        
        root = insert(node: root, value: value)
    }
    
    public mutating func remove(_ value: T) {
        func min(node: BinaryTreeNode<T>) -> T {
            return node.leftChild.map(min) ?? node.value
        }
        
        func remove(node: BinaryTreeNode<T>?, value: T) -> BinaryTreeNode<T>? {
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
            
            return node
        }
        
        root = remove(node: root, value: value)
    }
}
