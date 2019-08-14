import Foundation

public struct Tree<Node: TreeNodeProtocol, T>: TreeProtocol where Node.T == T {
    public var root: Node?
    
    public init(root: Node?) {
        self.root = root
    }
}

extension Tree: CustomStringConvertible where Node == BinaryTreeNode<T> { }
