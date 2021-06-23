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
        case delete
        case `continue`
        case yes
        case no
        case custom(title: String)
        
        var title: String {
            switch self {
            case .ok:
                return NSLocalizedString("event.action.ok", tableName: nil, bundle: Bundle(for: DialogView.self), value: "", comment: "")
            case .close:
                return NSLocalizedString("event.action.close", tableName: nil, bundle: Bundle(for: DialogView.self), value: "", comment: "")
            case .cancel:
                return NSLocalizedString("event.action.cancel", tableName: nil, bundle: Bundle(for: DialogView.self), value: "", comment: "")
            case .confirm:
                return NSLocalizedString("event.action.confirm", tableName: nil, bundle: Bundle(for: DialogView.self), value: "", comment: "")
            case .next:
                return NSLocalizedString("event.action.next", tableName: nil, bundle: Bundle(for: DialogView.self), value: "", comment: "")
            case .delete:
                return NSLocalizedString("event.action.delete", tableName: nil, bundle: Bundle(for: DialogView.self), value: "", comment: "")
            case .continue:
                return NSLocalizedString("event.action.continue", tableName: nil, bundle: Bundle(for: DialogView.self), value: "", comment: "")
            case .yes:
                return NSLocalizedString("event.action.yes", tableName: nil, bundle: Bundle(for: DialogView.self), value: "", comment: "")
            case .no:
                return NSLocalizedString("event.action.no", tableName: nil, bundle: Bundle(for: DialogView.self), value: "", comment: "")
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
