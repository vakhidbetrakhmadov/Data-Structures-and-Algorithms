import Foundation

public class Prim<G: Graph, T> where G.T == T {
    
    private let graph: G
    
    public init(graph: G) {
        self.graph = graph
    }
    
    public func mst(from vertex: Vertex<T>) -> (cost: Double, mst: AdjacencyList<T>) {
        var mst = AdjacencyList<T>()
        var cost = 0.0
        var visited = Set<Vertex<T>>()
        var queue = PriorityQueue<Edge<T>>(comparator: {
            ($0.weight ?? 0.0) < ($1.weight ?? 0.0)
        })
        
        copyVertices(from: graph, to: &mst)
        
        visited.insert(vertex)
        addAvailableEdges(for: vertex, to: &queue, visited: visited)
        
        while let edge = queue.dequeue() {
            guard !visited.contains(edge.destination) else { continue }
            
            cost += (edge.weight ?? 0)
            mst.addUndirectedEdge(from: edge.source, to: edge.destination, weight: edge.weight)
            
            visited.insert(edge.destination)
            addAvailableEdges(for: edge.destination, to: &queue, visited: visited)
        }
        
        return (cost, mst)
    }
    
    private func addAvailableEdges(for vertex: Vertex<T>, to queue: inout PriorityQueue<Edge<T>>, visited: Set<Vertex<T>>) {
        for edge in graph.edges(from: vertex) {
            guard !visited.contains(edge.destination) else { continue }
            queue.enqueue(value: edge)
        }
    }
    
    private func copyVertices(from source: G, to destination: inout AdjacencyList<T>) {
        source.vertices.forEach {
            destination.createVertex(value: $0.value)
        }
    }
}
