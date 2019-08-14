import Foundation

public protocol TreeProtocol where T == Node.T {
    associatedtype Node: TreeNodeProtocol
    associatedtype T
    
    typealias Visit = (T)->()
    
    var root: Node? { get set }
}

extension TreeProtocol {
    public func depthFirstTraversalR(visit: @escaping Visit) {
        guard let root = root else { return }
        
        func dft(node: Node) {
            visit(node.value)
            node.children.forEach(dft)
        }
        dft(node: root)
    }
    
    public func depthFirstTraversalS(visit: @escaping Visit) {
        guard let root = root else { return }
        
        var stack = Stack<Node>()
        var stacked = Set<Node>()
        
        stack.push(value: root)
        stacked.insert(root)
        visit(root.value)
        
        outer: while let node = stack.peek() {
            for node in node.children {
                guard !stacked.contains(node) else { continue }
                
                stack.push(value: node)
                stacked.insert(node)
                visit(node.value)
                continue outer
            }
            
            stack.pop()
        }
    }
    
    public func levelOrderTraversal(visit: @escaping Visit) {
        guard let root = root else { return }
        
        var queue = Queue<Node>()
        queue.enqueue(value: root)
        
        while let node = queue.dequeue() {
            visit(node.value)
            
            node.children.forEach {
                queue.enqueue(value: $0)
            }
        }
    }
}

extension TreeProtocol where Node == BinaryTreeNode<T> {
    public var description: String {
        var result = ""
        var index = 1
        var currentLevel = 0
        
        levelOrderTraversal(visit: { value in
            let level = Int(log2(Double(index)))
            
            result += (currentLevel != level) ? "\n" : ""
            result += "\(value) "
            
            currentLevel = level
            index += 1
        })
        
        return result
    }
    
    public func inOrderTraversal(visit: @escaping Visit) {
        func traverse(node: Node?) {
            guard let node = node else { return }
            traverse(node: node.leftChild)
            visit(node.value)
            traverse(node: node.rightChild)
        }
        traverse(node: root)
    }
    
    public func preOrderTraversal(visit: @escaping Visit) {
        func traverse(node: Node?) {
            guard let node = node else { return }
            visit(node.value)
            traverse(node: node.leftChild)
            traverse(node: node.rightChild)
        }
        traverse(node: root)
    }
    
    public func postOrderTraversal(visit: @escaping Visit) {
        func traverse(node: Node?) {
            guard let node = node else { return }
            traverse(node: node.leftChild)
            traverse(node: node.rightChild)
            visit(node.value)
        }
        traverse(node: root)
    }
}
