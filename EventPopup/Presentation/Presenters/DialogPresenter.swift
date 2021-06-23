//
//  DialogPresenter.swift
//  EventPopupExample
//
//  Created by Артём Борисенко on 22.06.21.
//

import Foundation
import UIKit


public final class DialogPresenter {
    /// The main application window. Dialog views will be presented on it.
    let appWindow: UIWindow? = {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .first { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }
                .map { $0 as? UIWindowScene }
                .map { $0?.windows.first } ?? UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow
        }

        return UIApplication.shared.delegate?.window ?? nil
    }()
    
    /// Delegate object that responsible for handling actions pressed in dialog view
    public weak var dialogEventDelegate: DialogEventActionDelegate?
    
    public init() {}
    
    /**
        Instantiates and displays the default dialog view for event.
     */
    private func showDefaultDialog(with event: Event) {
        guard let window = appWindow else { return }
        
        let dialogView = DefaultDialogView()
        dialogView.actionDelegate = dialogEventDelegate
        dialogView.event = event
        dialogView.translatesAutoresizingMaskIntoConstraints = false
                    
        window.addSubview(dialogView)
        NSLayoutConstraint.activate([
            dialogView.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 0.9),
            dialogView.heightAnchor.constraint(lessThanOrEqualTo: window.heightAnchor, multiplier: 0.6),
            dialogView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            dialogView.centerYAnchor.constraint(equalTo: window.centerYAnchor)
        ])
                
        dialogView.show()
    }
    
    /**
            Displays event view according to event kind
     */
    public func displayEvent(_ event: Event) {
        switch event.kind {
        case .error, .info, .success:
            showDefaultDialog(with: event)
        }
    }
}
