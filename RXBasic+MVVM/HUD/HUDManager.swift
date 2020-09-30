//
//  HUDManager.swift
//  RXBasic+MVVM
//
//  Created by Sungmin on 2020/09/25.
//  Copyright © 2020 sungmin.joo. All rights reserved.
//

import UIKit

final class HUDManager {

    static let shared = HUDManager()
    private init() {}

    private let floatingView = FloatingView()
    private var isHiddenFloatingButton = true

    private var window: UIWindow? {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }

    func clearHUD() {
        guard let window = window else { return }

        window.subviews.forEach { $0.removeFromSuperview() }
        isHiddenFloatingButton = true
    }

}

// MARK: - FloatingView
extension HUDManager {
    func setFloatingView(menuButtons: [UIButton]) {

        guard let window = window else { return }

        guard isHiddenFloatingButton else { return }
        isHiddenFloatingButton = false

        floatingView.translatesAutoresizingMaskIntoConstraints = false
        floatingView.childButtons = menuButtons
        floatingView.alpha = 0
        window.addSubview(floatingView)

        NSLayoutConstraint.activate([
            floatingView.topAnchor.constraint(
                equalTo: window.topAnchor
            ),
            floatingView.bottomAnchor.constraint(
                equalTo: window.bottomAnchor
            ),
            floatingView.leadingAnchor.constraint(
                equalTo: window.leadingAnchor
            ),
            floatingView.trailingAnchor.constraint(
                equalTo: window.trailingAnchor
            )
        ])

    }

    func showFloatingView() {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.floatingView.alpha = 1
        })
    }

    func hideFloatingView() {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.floatingView.alpha = 0
        })
    }
}
