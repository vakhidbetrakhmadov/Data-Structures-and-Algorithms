import Foundation

public struct Vertex<T>: Hashable where T: Hashable {
    public init(index: Int, value: T) {
        self.index = index
        self.value = value
    }
    
    public let index: Int
    public let value: T
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\((index, value))"
    }
}
