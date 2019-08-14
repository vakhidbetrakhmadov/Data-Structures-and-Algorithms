import Foundation

public struct Trie<CollectionType: Collection> where CollectionType.Element: Hashable {
    
    public typealias Node = TrieNode<CollectionType.Element>
    
    private let root = Node()
    
    public init() { }
    
    public func insert(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent: current)
            }
            
            current = current.children[element]!
        }
        
        current.isTerminating = true
    }
    
    public func remove(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            guard let next = current.children[element] else { return }
            current = next
        }
        
        current.isTerminating = false
        
        while let parent = current.parent, !current.isTerminating && current.children.isEmpty {
            parent.children[current.key!] = nil
            current = parent
        }
    }
    
    public func contains(_ collection: CollectionType) -> Bool {
        var current = root
        
        for element in collection {
            guard let next = current.children[element] else { return false }
            current = next
        }
        
        return current.isTerminating
    }
}

extension Trie where CollectionType: RangeReplaceableCollection {
    public func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        var result: [CollectionType] = []
        var current = root
        
        for element in prefix {
            guard let next = current.children[element] else { return result }
            current = next
        }
        
        func collections(startingWith prefix: CollectionType, after node: Node) {
            if node.isTerminating {
                result.append(prefix)
            }
            
            node.children.values.forEach { node in
                collections(startingWith: prefix + [node.key!], after: node)
            }
        }
        collections(startingWith: prefix, after: current)
        
        return result
    }
}
