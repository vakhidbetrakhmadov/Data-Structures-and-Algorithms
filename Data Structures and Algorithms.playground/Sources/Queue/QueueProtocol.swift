import Foundation

public protocol QueueProtocol {
    associatedtype T
    
    // MARK: - Properties
    
    var isEmpty: Bool { get }
    
    // MARK: - Methods
    
    mutating func enqueue(value: T)
    mutating func dequeue() -> T?
    func peek() -> T?
}
