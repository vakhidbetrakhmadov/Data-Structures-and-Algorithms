import Foundation

public struct Edge<T: Hashable> {
    public init(source: Vertex<T>, destination: Vertex<T>, weight: Double? = nil) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
    
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
}

extension Edge: CustomStringConvertible {
    public var description: String {
        return "\(source) - \(weight.map { String($0) } ?? "nil") -> \(destination)"
    }
}
