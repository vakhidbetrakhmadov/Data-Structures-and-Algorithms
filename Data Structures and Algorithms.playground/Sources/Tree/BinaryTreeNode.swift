import Foundation

final public class BinaryTreeNode<T: Hashable>: TreeNodeProtocol {
    public var value: T
    public var leftChild: BinaryTreeNode<T>?
    public var rightChild: BinaryTreeNode<T>?
    
    public var children: [BinaryTreeNode<T>] {
        return [leftChild, rightChild].compactMap { $0 }
    }
    
    public init(value: T, leftChild: BinaryTreeNode<T>? = nil, rightChild: BinaryTreeNode<T>? = nil) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}
