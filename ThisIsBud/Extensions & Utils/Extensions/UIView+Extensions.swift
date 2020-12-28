//
//  UIView+Extensions.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Layout
extension UIView {

    func prepareSubviewsForAutolayout(_ subviews: UIView...) {
        prepareSubviewsForAutolayout(subviews)
    }

    func prepareSubviewsForAutolayout(_ subviews: [UIView]) {
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func applyFullConstraints(to views: UIView..., withSafeAreas: Bool = false, withInset: CGFloat = .zero, for edges: UIRectEdge = .all) {
        applyFullConstraints(to: views, withSafeAreas: withSafeAreas, withInset: withInset, for: edges)
    }

    func applyFullConstraints(to views: [UIView], withSafeAreas: Bool, withInset: CGFloat, for edges: UIRectEdge = .all) {
        views.forEach {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: withSafeAreas ? safeAreaLayoutGuide.topAnchor : topAnchor, constant: edges.contains(.top) ? withInset : 0.0),
                $0.bottomAnchor.constraint(equalTo: withSafeAreas ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor, constant: edges.contains(.bottom) ? -withInset : 0.0),
                $0.leadingAnchor.constraint(equalTo: withSafeAreas ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor, constant: edges.contains(.left) ? withInset : 0.0),
                $0.trailingAnchor.constraint(equalTo: withSafeAreas ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor, constant: edges.contains(.right) ? -withInset : 0.0)
            ])
        }
    }

}

// MARK: - Layer
extension UIView {

    func blurView(isLight: Bool = false) {
        backgroundColor = .clear

        let blurEffect = UIBlurEffect(style: isLight ? .light : .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        prepareSubviewsForAutolayout(blurEffectView)
        applyFullConstraints(to: blurEffectView)
    }

    func roundView(with value: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = value
    }

}

// MARK: - Animations
extension UIView {

    func fadeIn(with duration: TimeInterval = 0.5) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: duration) {
                self?.alpha = 1.0
            }
        }
    }

    func fadeOut(with duration: TimeInterval = 0.5) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: duration) {
                self?.alpha = 0.0
            }
        }
    }

}
