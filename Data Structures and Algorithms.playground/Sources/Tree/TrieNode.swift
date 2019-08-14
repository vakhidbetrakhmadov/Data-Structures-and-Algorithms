import Foundation

public class TrieNode<Key: Hashable> {
    
    public var key: Key?
    
    public weak var parent: TrieNode<Key>?
    
    public var children: [Key: TrieNode<Key>] = [:]
    
    public var isTerminating: Bool
    
    public init(key: Key? = nil, parent: TrieNode<Key>? = nil, isTerminating: Bool = false) {
        self.key = key
        self.parent = parent
        self.isTerminating = isTerminating
    }
}
