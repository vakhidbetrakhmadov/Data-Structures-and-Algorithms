import Foundation

public struct AdjacencyList<T: Hashable>: Graph {
    
    private var container: [Vertex<T>:[Edge<T>]] = [:]
    
    public var vertices: [Vertex<T>] {
        return Array(container.keys).sorted(by: { $0.index < $1.index })
    }
    
    public init() { }
    
    @discardableResult
    public mutating func createVertex(value: T) -> Vertex<T> {
        let vertex = Vertex(index: container.count, value: value)
        container[vertex] = []
        return vertex
    }
    
    public mutating func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double? = nil) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        container[source]?.append(edge)
    }
    
    public func edges(from vertex: Vertex<T>) -> [Edge<T>] {
        return container[vertex, default: []]
    }
    
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        return container[source]?.first(where: { $0.destination == destination })?.weight
    }
}
