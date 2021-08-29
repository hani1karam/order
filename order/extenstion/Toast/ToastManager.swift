//
//  ToastManager.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import Foundation
import Cosmos
class ToastManager {
    //MARK: Properties
    static let shared = ToastManager()
    private var view: UIView = UIView()
    private var message: String = ""
    private var bottomAnchor: NSLayoutConstraint!
    private var errorHeaders: [ToastView?] = []
    
    //MARK: Methods
    private init() {}
    
    func showError(message: String, view: UIView, backgroundColor: UIColor) {
        let errorHeader: ToastView? = ToastView()
        errorHeaders.forEach({
            hideBanner(errorHeader: $0)
        })
        errorHeaders.append(errorHeader)
        self.view = view
        errorHeader?.contentView.backgroundColor = backgroundColor
        self.message = message
        guard self.message != "" else {return}
        createBannerWithInitialPosition(errorHeader: errorHeader)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.hideBanner(errorHeader: errorHeader)
        }
    }
    
    private func createBannerWithInitialPosition(errorHeader: ToastView?) {
        guard let errorHeader = errorHeader else { return }
        errorHeader.errorLabel.font = .boldSystemFont(ofSize: 14)
        errorHeader.errorLabel.text = message
        errorHeader.layer.cornerRadius = 10
        errorHeader.layer.masksToBounds = true
        view.addSubview(errorHeader)
        let guide = view.safeAreaLayoutGuide
        errorHeader.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor = errorHeader.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 100)
        bottomAnchor.isActive = true
        errorHeader.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: -20).isActive = true
        errorHeader.leadingAnchor.constraint(greaterThanOrEqualTo: guide.leadingAnchor, constant: 20).isActive = true
        errorHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorHeader.heightAnchor.constraint(equalToConstant: errorHeader.viewHeight).isActive = true
        view.layoutIfNeeded()
        animateBannerPresentation()
    }
    
    private func animateBannerPresentation() {
        if KeyboardStateManager.shared.isVisible {
            bottomAnchor.constant = -KeyboardStateManager.shared.keyboardOffset
        } else {
            bottomAnchor.constant = -20
        }
        UIView.animate(withDuration: 0.3, delay: 0.2, options: [], animations: { [weak self] in self?.view.layoutIfNeeded() }, completion: nil)
    }
    
    private func hideBanner(errorHeader: ToastView?) {
        UIView.animate(withDuration: 0.5, animations: {
            errorHeader?.alpha = 0
        }) { _ in
            errorHeader?.removeFromSuperview()
        }
    }
}
