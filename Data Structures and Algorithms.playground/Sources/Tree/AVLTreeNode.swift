import Foundation

final public class AVLTreeNode<T: Hashable>: TreeNodeProtocol {
    public var value: T
    public var leftChild: AVLTreeNode<T>?
    public var rightChild: AVLTreeNode<T>?
    
    public var children: [AVLTreeNode<T>] {
        return [leftChild, rightChild].compactMap { $0 }
    }
    
    public var height: Int
    
    public var leftChildHeight: Int {
        return leftChild?.height ?? -1
    }
    
    public var rightChildHeight: Int {
        return rightChild?.height ?? -1
    }
    
    public var balance: Int {
        return leftChildHeight - rightChildHeight
    }
    
    public init(value: T, leftChild: AVLTreeNode<T>? = nil, rightChild: AVLTreeNode<T>? = nil) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.height = 0
    }
}
