//
//  Event.swift
//  EventPopupExample
//
//  Created by Артём Борисенко on 21.06.21.
//

import Foundation

public struct EventInfoKey: Hashable {
    var key: String
    
    public static let serviceId = EventInfoKey(key: "serviceId")
    public static let eventData = EventInfoKey(key: "eventData")
}

public struct Event {
    public enum Kind: String, Hashable {        
        case error
        case info
        case success
    }
    
    public enum Action: Hashable {
        case ok
        case close
        case confirm
        case cancel
        case next
        case custom(title: String)
        
        var title: String {
            switch self {
            case .ok:
                return "OK"
            case .close:
                return "Close"
            case .cancel:
                return "Cancel"
            case .confirm:
                return "Confirm"
            case .next:
                return "Next"
            case let .custom(title):
                return title
            }
        }
    }
    
    var title: String
    var message: String
    let kind: Event.Kind
    var actions: [Event.Action]
    var eventInfo: [EventInfoKey: Any]
    
    public init(title: String, message: String, kind: Event.Kind, actions: [Event.Action], eventInfo: [EventInfoKey: Any] = [:]) {
        self.title = title
        self.message = message
        self.kind = kind
        self.actions = actions
        self.eventInfo = eventInfo
    }
}
