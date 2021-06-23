//
//  DialogEventActionDelegate.swift
//  EventPopupExample
//
//  Created by Артём Борисенко on 22.06.21.
//

import Foundation

public protocol DialogEventActionDelegate: AnyObject {
    func didPressAction(action: Event.Action, eventInfo: [EventInfoKey: Any])
}
