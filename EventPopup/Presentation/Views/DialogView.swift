//
//  DialogView.swift
//  EventPopupExample
//
//  Created by Артём Борисенко on 22.06.21.
//

import UIKit

public class DialogView: UIView {
    // MARK: - Views
    /// Container view for placing dialog content except the action buttons.
    private let infoContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .white
        return view
    }()

    /// Container view for action buttons
    private let actionsContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UIColor(red: 18 / 255.0, green: 18 / 255.0, blue: 18 / 255.0, alpha: 0.05)
        return view
    }()
    
    /// Views that arranges action buttons right
    private let actionButtonsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    /// Main container
    private let contentView = UIView(frame: .zero)
    
    // MARK: - Public properties
    /// Delegate object that responsible for handling pressed actions
    public weak var actionDelegate: DialogEventActionDelegate?
    
    /// Source of content displayed
    public var event: Event? {
        didSet {
            guard let event = event else { return }
            configure(with: event)
        }
    }
    
    // MARK: - Inits
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDefaultAppearance()
        buildViewHierarchy()
        setupDefaultConstraints()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaultAppearance()
        buildViewHierarchy()
    }

    public convenience init(frame: CGRect = .zero, infoView: UIView) {
        self.init(frame: frame)
        setInfoView(infoView)
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        buildViewHierarchy()
    }
    
    /**
        Fills view with event content. Subclasses can override this method to configure additional content, but must call super.
     */
    func configure(with event: Event) {
        actionButtonsStackView.subviews.forEach { $0.removeFromSuperview() }

        event.actions.forEach {
            let button = makeActionButton(with: $0)
            actionButtonsStackView.addArrangedSubview(button)
        }

        setNeedsLayout()
    }
    
    /**
        Prepares dialog window for default appear animation.
     */
    public func prepareToDisplay() {
        isHidden = true
        layoutIfNeeded()
        transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        alpha = 0
    }
    
    /**
        Shows the dialog view. If subclass overrides this method to change appear animation, it must override `prepareToDisplay()` method too.
     */
    public func show() {
        prepareToDisplay()
        
        isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [.curveLinear, .allowUserInteraction]) {
            self.transform = CGAffineTransform.identity
            self.alpha = 1
        }
    }
    
    /**
        Dismisses the dialog view.
     */
    public func dismiss() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [.curveLinear, .allowUserInteraction]) {
            self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.alpha = 0
        } completion: { finished in
            if finished {
                self.isHidden = true
                self.removeFromSuperview()
            }
        }
    }
}

// MARK: - Layout (Private)
private extension DialogView {
    func setupDefaultAppearance() {
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 3
        
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }
    
    func buildViewHierarchy() {
        addSubview(contentView)
        contentView.frame = bounds

        contentView.addSubview(infoContainerView)
        infoContainerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.75)

        contentView.addSubview(actionsContainerView)
        actionsContainerView.frame = CGRect(x: 0, y: frame.height * 0.75, width: frame.width, height: frame.height * 0.25)
        
        actionsContainerView.addSubview(actionButtonsStackView)
        actionButtonsStackView.frame = actionsContainerView.bounds
    }
    
    func setupDefaultConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        guard contentView.isDescendant(of: self) else { return }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        guard infoContainerView.isDescendant(of: contentView) else { return }
        infoContainerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            infoContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        guard actionsContainerView.isDescendant(of: contentView) else { return }
        actionsContainerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            actionsContainerView.topAnchor.constraint(equalTo: infoContainerView.bottomAnchor),
            actionsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actionsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actionsContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            actionsContainerView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        guard actionButtonsStackView.isDescendant(of: actionsContainerView) else { return }
        actionButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionButtonsStackView.topAnchor.constraint(equalTo: actionsContainerView.topAnchor),
            actionButtonsStackView.leadingAnchor.constraint(equalTo: actionsContainerView.leadingAnchor),
            actionButtonsStackView.trailingAnchor.constraint(equalTo: actionsContainerView.trailingAnchor),
            actionButtonsStackView.bottomAnchor.constraint(equalTo: actionsContainerView.bottomAnchor)
        ])
    }
}

// MARK: - UI Configuration helpers (Private)
private extension DialogView {
    func makeActionButton(with action: Event.Action) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle(action.title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didPressButton(sender:)), for: .touchUpInside)
        
        return button
    }
}

// MARK: - Events
private extension DialogView {
    @objc func didPressButton(sender: UIButton) {
        if let actionIndex = actionButtonsStackView.arrangedSubviews.firstIndex(of: sender), let action = event?.actions[actionIndex] {
            dismiss()
            actionDelegate?.didPressAction(action: action, eventInfo: event?.eventInfo ?? [:])
        }
    }
}

// MARK: - UI Customization
public extension DialogView {
    func setInfoView(_ view: UIView) {
        infoContainerView.subviews.forEach { $0.removeFromSuperview() }
        infoContainerView.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: infoContainerView.topAnchor),
            view.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor)
        ])

        setNeedsLayout()
    }
}
