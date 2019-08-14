import Foundation

public class Dijkstra1<G: Graph, T> where G.T == T {
    
    public enum Visit {
        case start
        case edge(Edge<T>)
    }
    
    private let graph: G
    
    public init(graph: G) {
        self.graph = graph
    }
    
    public func route(to vertex: Vertex<T>, shortesPath: [Vertex<T>: Visit]) -> [Edge<T>] {
        var vertex = vertex
        var edges: [Edge<T>] = []
        
        while let visit = shortesPath[vertex], case .edge(let edge) = visit {
            edges = [edge] + edges
            vertex = edge.source
        }
        
        return edges
    }
    
    public func distance(to vertex: Vertex<T>, shortesPath: [Vertex<T>: Visit]) -> Double {
        return route(to: vertex, shortesPath: shortesPath)
            .compactMap { $0.weight }
            .reduce(0, +)
    }
    
    public func shortestPath(from vertex: Vertex<T>) -> [Vertex<T>: Visit] {
        var shortesPath: [Vertex<T>: Visit] = [vertex:.start]
        var queue = PriorityQueue<Vertex<T>>(comparator: {
            self.distance(to: $0, shortesPath: shortesPath) < self.distance(to: $1, shortesPath: shortesPath)
        })
        
        queue.enqueue(value: vertex)
        
        while let vertex = queue.dequeue() {
            for edge in graph.edges(from: vertex) {
                guard let weight = edge.weight else { continue }
                
                if shortesPath[edge.destination] == nil ||
                    ((distance(to: vertex, shortesPath: shortesPath) + weight)
                        < distance(to: edge.destination, shortesPath: shortesPath)) {
                    shortesPath[edge.destination] = .edge(edge)
                    queue.enqueue(value: edge.destination)
                }
            }
        }
        
        return shortesPath
    }
}


public class Dijkstra2<G: Graph, T> where G.T == T {
    
    private let graph: G
    
    public init(graph: G) {
        self.graph = graph
    }
    
    public func route(to vertex: Int, shortestPath: [Int]) -> [Int] {
        var current = vertex
        var path: [Int] = []
        
        while shortestPath[current] != -1 {
            path = [current] + path
            current = shortestPath[current]
        }
        
        return [current] + path
    }
    
    public func distance(to vertex: Int, shortestPath: [Int]) -> Double {
        let route = self.route(to: vertex, shortestPath: shortestPath)
        
        return (0...route.count-2)
            .compactMap { graph.weight(from: graph.vertices[route[$0]], to: graph.vertices[route[$0+1]]) }
            .reduce(0, +)
    }
    
    public func shortestPath(from vertex: Int) -> [Int] {
        var shortestPath: [Int] = .init(repeating: -1, count: graph.vertices.count)
        var queue = PriorityQueue<Int>(comparator: {
            self.distance(to: $0, shortestPath: shortestPath) < self.distance(to: $1, shortestPath: shortestPath)
        })
        
        queue.enqueue(value: vertex)
        
        while let next = queue.dequeue() {
            for edge in graph.edges(from: graph.vertices[next]) {
                guard edge.destination.index != vertex else { continue }
                guard let weight = edge.weight else { continue }
                
                if shortestPath[edge.destination.index] == -1 ||
                    ((distance(to: next, shortestPath: shortestPath) + weight)
                        < distance(to: edge.destination.index, shortestPath: shortestPath)) {
                    shortestPath[edge.destination.index] = next
                    queue.enqueue(value: edge.destination.index)
                }
            }
        }
        
        return shortestPath
    }
}
