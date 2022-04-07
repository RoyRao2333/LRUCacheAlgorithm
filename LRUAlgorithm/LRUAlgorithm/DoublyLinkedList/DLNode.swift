//
//  DLNode.swift
//  DoublyLinkedList-Swift
//
//  Created by Roy on 2021/7/14.
//

import Foundation


// MARK: List Node -
public class DLNode<Value> {
    public var key: String
    public var value: Value
    public var next: DLNode?
    public var prev: DLNode?
    
    
    public init(key: String, value: Value, next: DLNode? = nil, prev: DLNode? = nil) {
        self.key = key
        self.value = value
        self.next = next
        self.prev = prev
    }
}
