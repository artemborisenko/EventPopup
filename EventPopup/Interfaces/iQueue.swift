//
//  iQueue.swift
//  EventPopupExample
//
//  Created by Артём Борисенко on 22.06.21.
//

import Foundation

public protocol iQueue {
  associatedtype Element
  mutating func enqueue(_ element: Element) -> Bool
  mutating func dequeue() -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}
