import Foundation

public protocol LinkedListProtocol: Collection, CustomStringConvertible where Self.Value == Self.Node.Value {
    associatedtype Value
    associatedtype Node: NodeProtocol
    
    var head: Node? { get }
    var tail: Node? { get }
    var count: Int { get }
    
    mutating func push(_ value: Value)
    mutating func pop() -> Value?
    mutating func append( _ value: Value)
    mutating func removeLast() -> Value?
    mutating func insert(_ value: Value, after node: Node) -> Node
    mutating func remove(after node: Node) -> Value?
    func node(at index: Int) -> Node?
}

extension LinkedListProtocol {
    public var description: String {
        return map { "[\($0)]" }.reduce("", { $0.isEmpty ? $1 : "\($0) -> \($1) "})
    }
}


public protocol DoubleLinkedListProtocol: BidirectionalCollection, LinkedListProtocol where Self.Node: DoubleNodeProtocol { }

extension DoubleLinkedListProtocol {
    public var description: String {
        return map { "[\($0)]" }.reduce("", { $0.isEmpty ? $1 : "\($0) <-> \($1)"})
    }
}
