//
//  Queue.swift
//  EventPopupExample
//
//  Created by Артём Борисенко on 21.06.21.
//

import Foundation

public struct Queue<T>: iQueue {
    private var dequeStack: [T] = []
    private var enqueueStack: [T] = []
    
    public var isEmpty: Bool {
        dequeStack.isEmpty && enqueueStack.isEmpty
    }
    
    public var peek: T? {
        dequeStack.isEmpty ? enqueueStack.first : dequeStack.last
    }
    
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        enqueueStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if dequeStack.isEmpty {
            dequeStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        
        return dequeStack.popLast()
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        let eventsList = dequeStack.reversed() + enqueueStack
        return String(describing: eventsList)
    }
}
