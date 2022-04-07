//
//  main.swift
//  LRUAlgorithm
//
//  Created by roy on 2022/4/7.
//

import Foundation

let lRUCache = LRUCache<Int>(capacity: 2)
lRUCache.put(1, forKey: "1") // 缓存是 {1=1}
lRUCache.put(2, forKey: "2") // 缓存是 {1=1, 2=2}
print(lRUCache.get(forKey: "1"))    // 返回 1
lRUCache.put(3, forKey: "3") // 该操作会使得关键字 2 作废，缓存是 {1=1, 3=3}
print(lRUCache.get(forKey: "2"))    // 返回 -1 (未找到)
lRUCache.put(4, forKey: "4") // 该操作会使得关键字 1 作废，缓存是 {4=4, 3=3}
print(lRUCache.get(forKey: "1"))    // 返回 -1 (未找到)
print(lRUCache.get(forKey: "3"))    // 返回 3
print(lRUCache.get(forKey: "4"))    // 返回 4
