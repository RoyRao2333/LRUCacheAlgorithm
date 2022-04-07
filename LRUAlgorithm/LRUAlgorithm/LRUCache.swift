//
//  LRUCache.swift
//  LRUAlgorithm
//
//  Created by roy on 2022/4/7.
//

import Foundation

public class LRUCache<Value>: NSObject where Value: Hashable {
    private var storage = [String: DLNode<Value>]()
    private var cacheList = DLList<Value>()
    private var capacity: UInt
    
    init(capacity: UInt) {
        self.capacity = capacity
    }
}

// MARK: Public Methods -
extension LRUCache {
    
    public func get(forKey key: String) -> Value? {
        makeRecent(key: key)?.value
    }
    
    public func put(_ value: Value, forKey key: String) {
        guard !storage.contains(where: { $0.key == key }) else {
            remove(key: key)
            appendCache(key: key, value: value)
            return
        }
        
        if cacheList.count >= capacity {
            removeLeastRecent()
        }
        
        appendCache(key: key, value: value)
    }
}

// MARK: Private Methods -
extension LRUCache {
    
    private func makeRecent(key: String) -> DLNode<Value>? {
        guard let node = storage[key] else { return nil }
        
        cacheList.remove(node)
        cacheList.append(node.value, forKey: node.key)
        
        return node
    }
    
    private func appendCache(key: String, value: Value) {
        guard !key.isEmpty else { return }
        
        let node = cacheList.append(value, forKey: key)
        storage[key] = node
    }
    
    private func remove(key: String) {
        guard let node = storage[key] else { return }
        
        cacheList.remove(node)
        storage.removeValue(forKey: key)
    }
    
    private func removeLeastRecent() {
        guard let removed = cacheList.removeFirst() else { return }
        storage.removeValue(forKey: removed.key)
    }
}
