import Foundation

public struct AdjacencyMatrix<T: Hashable>: Graph {
    
    private var verteces: [Vertex<T>] = []
    private var weights: [[Double?]] = []
    
    public var vertices: [Vertex<T>] {
        return verteces
    }
    
    public init() { }
    
    @discardableResult
    public mutating func createVertex(value: T) -> Vertex<T> {
        let vertex = Vertex(index: verteces.count, value: value)
        verteces.append(vertex)
        weights.append([Double?](repeating: Double.infinity, count: weights.count))
        for index in (weights.startIndex..<weights.endIndex) {
            weights[index].append(Double.infinity)
        }
        return vertex
    }
    
    public mutating func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double? = nil) {
        weights[source.index][destination.index] = weight
    }
    
    public func edges(from vertex: Vertex<T>) -> [Edge<T>] {
        return weights[vertex.index]
            .enumerated()
            .filter { $0.element != Double.infinity }
            .compactMap { offset, weight in
                weight.map { Edge(source: vertex, destination: verteces[offset], weight: $0) }
        }
    }
    
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        let weight = weights[source.index][destination.index]
        return weight == Double.infinity ? nil : weight
    }
}
