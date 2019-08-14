import Foundation

final public class TreeNode<T: Hashable>: TreeNodeProtocol {
    public var value: T
    public var children: [TreeNode<T>]
    
    public init(value: T, children: [TreeNode<T>] = []) {
        self.value = value
        self.children = children
    }
}
