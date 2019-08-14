import Foundation

public protocol TreeNodeProtocol: Hashable {
    associatedtype T: Hashable
    
    var value: T { get set }
    var children: [Self] { get }
}

extension TreeNodeProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value && lhs.children == rhs.children
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}
