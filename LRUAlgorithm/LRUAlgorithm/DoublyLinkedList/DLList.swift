//
//  DLList.swift
//  DLList-Swift
//
//  Created by Roy on 2021/7/14.
//

import Foundation


// MARK: Doubly Linked List
public class DLList<Value> {
    public private(set) var head: DLNode<Value>?
    public private(set) var tail: DLNode<Value>?
    public private(set) var count: UInt = 0
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    
    /**
     *  This operation will initialize the head of a `DLList` if the parameter `value` isn't `nil`.
     *  Otherwise, an empty `DLList` instance will be created.
     *
     *  - Parameters:
     *      - value: The value for the head.
     */
    public init(_ value: Value? = nil, forKey key: String? = nil) {
        if let key = key, let value = value {
            head = DLNode(key: key, value: value)
            tail = head
            count = 1
        }
    }
}


// MARK: Public Methods -
extension DLList {
    
    /**
     *  Find and return the `DLNode` at the given index.
     *
     *  - Parameters:
     *      - index: A node's position in list.
     *
     *  - Returns: A `DLNode` of the `DLList` if available.
     */
    public func node(at index: UInt) -> DLNode<Value>? {
        guard index < count else { return nil }
        
        var currentIndex = 0
        var currentNode = head
        
        while currentIndex < index, currentNode != nil {
            currentIndex += 1
            currentNode = currentNode?.next
        }
        
        return currentNode
    }
    
    /**
     *  Add element to the front of a `DLList`.
     *
     *  - Parameters:
     *      - value: The value you want to add.
     *
     *  - Returns: The new `DLNode` just inserted.
     */
    @discardableResult
    public func insertFront(_ value: Value, forKey key: String) -> DLNode<Value> {
        let newNode = DLNode(key: key, value: value, next: head, prev: nil)
        head?.prev = newNode
        head = newNode
        
        // Only One Node Left in List
        if tail == nil {
            tail = head
        }
        
        count += 1
        
        return newNode
    }
    
    /**
     *  Add element to the tail of a `DLList`.
     *
     *  - Parameters:
     *      - value: The value you want to add.
     *
     *  - Returns: The new `DLNode` just appended.
     */
    @discardableResult
    public func append(_ value: Value, forKey key: String) -> DLNode<Value> {
        guard !isEmpty else {
            return insertFront(value, forKey: key)
        }
        
        let newNode = DLNode(key: key, value: value, next: nil, prev: tail)
        tail?.next = newNode
        tail = newNode
        count += 1
        
        return newNode
    }
    
    /**
     *  Add element to a `DLList` after a existing node.
     *
     *  - Parameters:
     *      - value: The value you want to add.
     *      - node: The existing node before the node you want to add.
     *
     *  - Returns: The new `DLNode` just added.
     */
    @discardableResult
    public func insert(_ value: Value, forKey key: String, after node: DLNode<Value>) -> DLNode<Value> {
        if node === tail {
            append(value, forKey: key)
            
            return tail!
        }
        
        node.next = DLNode(key: key, value: value, next: node.next, prev: node)
        count += 1
        
        return node.next!
    }
    
    /**
     *  Add element to a `DLList` before a existing node.
     *
     *  - Parameters:
     *      - value: The value you want to add.
     *      - node: The existing node after the node you want to add.
     *
     *  - Returns: The new `DLNode` just added.
     */
    @discardableResult
    public func insert(_ value: Value, forKey key: String, before node: DLNode<Value>) -> DLNode<Value> {
        if node === head {
            insertFront(value, forKey: key)
            
            return head!
        }
        
        node.prev = DLNode(key: key, value: value, next: node, prev: node.prev)
        count += 1
        
        return node.prev!
    }
    
    /**
     *  Add element to a position in a `DLList` by  a given index.
     *
     *  - Parameters:
     *      - value: The value you want to add.
     *      - index: The position you want the value to be added.
     *
     *  - Returns: The new `DLNode` if added successfully.
     */
    @discardableResult
    public func insert(_ value: Value, forKey key: String, at index: UInt) -> DLNode<Value>? {
        guard !isEmpty else {
            return insertFront(value, forKey: key)
        }
        
        guard index != 0 else {
            return insert(value, forKey: key, after: head!)
        }
        
        if let node = node(at: index - 1) {
            return insert(value, forKey: key, after: node)
        }
        
        return nil
    }
    
    /**
     *  Remove the first element from a `DLList`.
     *
     *  - Returns: The value stored by the removed node if available.
     */
    @discardableResult
    public func removeFirst() -> DLNode<Value>? {
        guard !isEmpty else { return nil }
        
        let oldHead = head
        head = oldHead?.next
        count -= 1
        
        // Only One Node Left in List
        if tail === oldHead {
            tail = nil
        }
        
        return oldHead
    }
    
    /**
     *  Remove the last element from a `DLList`.
     *
     *  - Returns: The value stored by the removed node if available.
     */
    @discardableResult
    public func removeLast() -> DLNode<Value>? {
        guard count > 1 else { return removeFirst() }
        
        let removedNode = tail
        let newTail = tail?.prev
        newTail?.next = nil
        tail = newTail
        count -= 1
        
        return removedNode
    }
    
    /**
     *  Remove the element after a given existing node from a `DLList`.
     *
     *  - Parameters:
     *      - node: The existing node before the node you want to remove.
     *
     *  - Returns: The value of the new node after the parameter `node` if available.
     */
    @discardableResult
    public func remove(after node: DLNode<Value>) -> DLNode<Value>? {
        guard node.next != nil else { return nil }
        
        guard node.next?.next != nil else {
            return removeLast()
        }
        
        node.next = node.next?.next
        count -= 1
        
        return node.next
    }
    
    /**
     *  Returns the value of the new node before the parameter `node` if available.
     *
     *  Remove the element before a given existing node from a `DLList`.
     *
     *  - Parameters:
     *      - node: The existing node after the node you want to remove.
     */
    @discardableResult
    public func remove(before node: DLNode<Value>) -> DLNode<Value>? {
        guard node.prev != nil else { return nil }
        
        guard node.prev?.prev != nil else {
            return removeFirst()
        }
        
        node.prev = node.prev?.prev
        count -= 1
        
        return node.prev
    }
    
    /**
     *  Remove the element by a given index from a `DLList`.
     *
     *  - Parameters:
     *      - index: The position of the node you want to remove.
     *
     *  - Returns: The value stored by the removed node if available.
     */
    @discardableResult
    public func remove(at index: UInt) -> DLNode<Value>? {
        guard index < count else { return nil }
        
        if index == 0 {
            return removeFirst()
        } else if index == count - 1 {
            return removeLast()
        }
        
        if let node = node(at: index - 1) {
            return remove(after: node)
        }
        
        return nil
    }
    
    /**
     *  Remove the element by a given index from a `DLList`.
     *
     *  - Parameters:
     *      - index: The position of the node you want to remove.
     *
     *  - Returns: The value stored by the removed node if available.
     */
    @discardableResult
    public func remove(_ node: DLNode<Value>) -> DLNode<Value>? {
        guard let prevNode = node.prev else {
            return removeFirst()
        }
        
        guard let nextNode = node.next else {
            return removeLast()
        }
        
        prevNode.next = nextNode
        nextNode.prev = prevNode
        count -= 1
        
        return node
    }
    
    /**
     *  Get all stored nodes.
     *
     *  - Returns: All values stored by nodes in a `DLList`.
     */
    public func allNodes() -> [Value] {
        guard !isEmpty else { return [] }
        
        var current = head
        var result: [Value] = []
        
        while let value = current?.value {
            result.append(value)
            
            current = current?.next
        }
        
        return result
    }
}
