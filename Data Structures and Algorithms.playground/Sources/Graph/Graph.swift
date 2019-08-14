import Foundation

public protocol Graph: CustomStringConvertible {
    associatedtype T: Hashable
    
    var vertices: [Vertex<T>] { get }
    
    @discardableResult
    mutating func createVertex(value: T) -> Vertex<T>
    mutating func addUndirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?)
    mutating func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?)
    func edges(from vertex: Vertex<T>) -> [Edge<T>]
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double?
}

extension Graph {
    public mutating func addUndirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double? = nil) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    public func bfs(start vertex: Vertex<T>) -> [Vertex<T>] {
        var result = [Vertex<T>]()
        var enqueued: Set<Vertex<T>> = []
        var queue = Queue<Vertex<T>>()
        
        queue.enqueue(value: vertex)
        enqueued.insert(vertex)
        
        while let vertex = queue.dequeue() {
            result.append(vertex)
            
            let neighbors = edges(from: vertex).map { $0.destination }
            
            for neighbor in neighbors {
                guard !enqueued.contains(neighbor) else { continue }
                
                queue.enqueue(value: neighbor)
                enqueued.insert(neighbor)
            }
        }
        
        return result
    }
    
    public func dfs(start vertex: Vertex<T>) -> [Vertex<T>] {
        var result: [Vertex<T>] = []
        var stacked: Set<Vertex<T>> = []
        var stack = Stack<Vertex<T>>()
        
        stack.push(value: vertex)
        stacked.insert(vertex)
        result.append(vertex)
        
        outer: while let vertex = stack.peek() {
            let neighbors = edges(from: vertex).map { $0.destination }
            
            for neighbor in neighbors {
                if !stacked.contains(neighbor) {
                    stack.push(value: neighbor)
                    stacked.insert(neighbor)
                    result.append(neighbor)
                    
                    continue outer
                }
            }
            
            stack.pop()
        }
        
        return result
    }
    
    public func dfsr(start vertex: Vertex<T>) -> [Vertex<T>] {
        var result: [Vertex<T>] = []
        var stacked: Set<Vertex<T>> = []
        
        func dfsr(start vertex: Vertex<T>) {
            guard !stacked.contains(vertex) else { return }
            
            stacked.insert(vertex)
            result.append(vertex)
            
            let neighbors = edges(from: vertex).map { $0.destination }
            neighbors.forEach { neighbor in
                dfsr(start: neighbor)
            }
        }
        
        dfsr(start: vertex)
        
        return result
    }
}

extension Graph {
    public var description: String {
        return vertices.reduce("", { acc, vertex in
            let edges = self.edges(from: vertex)
            let empty =  "\t"
            
            return acc + vertex.description + "\n" + edges.reduce("", { acc, edge in
                acc + edge.description.replacingOccurrences(of: vertex.description, with: empty) + "\n"
            })
        })
    }
}
