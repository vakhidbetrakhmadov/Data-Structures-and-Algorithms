import Foundation

// MARK: - NodeProtocol

public protocol NodeProtocol: class, CustomStringConvertible {
    associatedtype Value
    
    var value: Value { get }
    var next: Self? { get }
}

internal protocol MutableNodeProtocol: NodeProtocol {
    var value: Value { get set }
    var next: Self? { get set }
}

extension NodeProtocol {
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> \(next.description) "
    }
}

// MARK: - DoubleNodeProtocol

public protocol DoubleNodeProtocol: NodeProtocol {
    var previous: Self? { get }
}

internal protocol MutableDoubleNodeProtocol: MutableNodeProtocol {
    var previous: Self? { get set }
}

extension DoubleNodeProtocol {
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) <-> \(next.description) "
    }
}
