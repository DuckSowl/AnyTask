//
//  UIView+.swift
//  AnyTask
//
//  Created by Anton Tolstov on 03.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit
import Pin

extension UIView {
    
    // MARK: - Conrner Radius
    
    func set(cornerRadius: CGFloat, for corners: [Corner] = [.all]) {
        if #available(iOS 11.0, *) {
            layer.maskedCorners = corners.mask
            layer.cornerRadius = cornerRadius
        } else {
            // Add corners for iOS 10
        }
    }
    
    func set(cornerRadius: CGFloat, for corners: Corner...) {
        set(cornerRadius: cornerRadius, for: corners)
    }
    
    // MARK: - Functional View Configurators
    
    func with(backgroundColor: UIColor) -> UIView {
        self.backgroundColor = backgroundColor
        return self
    }
    
    func with(contentMode: ContentMode) -> UIView {
        self.contentMode = contentMode
        return self
    }
    
    func with(cornerRadius: CGFloat, for corners: Corner...) -> UIView {
        with(cornerRadius: cornerRadius, for: corners)
    }
    
    func with(cornerRadius: CGFloat, for corners: [Corner] = [.all]) -> UIView {
        set(cornerRadius: cornerRadius, for: corners)
        return self
    }
    
    func `as`<UIView>(_: UIView.Type) -> UIView {
        self as! UIView
    }
    
    // MARK: - Conrner Radius Cases
    
    func set(cornerRadius: CornerRadius.Cases, for corners: [Corner] = [.all]) {
        set(cornerRadius: cornerRadius.rawValue, for: corners)
    }
    
    func set(cornerRadius: CornerRadius.Cases, for corners: Corner...) {
        set(cornerRadius: cornerRadius.rawValue, for: corners)
    }
    
    func with(cornerRadius: CornerRadius.Cases, for corners: Corner...) -> UIView {
        with(cornerRadius: cornerRadius.rawValue, for: corners)
    }
    
    func with(cornerRadius: CornerRadius.Cases, for corners: [Corner] = [.all]) -> UIView {
        set(cornerRadius: cornerRadius.rawValue, for: corners)
        return self
    }
    
    // MARK: - Constraints
    
    var sizeThatFitsSelf: CGSize {
        sizeThatFits(self.frame.size)
    }
    
    func getConstraint(for attribute: NSLayoutConstraint.Attribute,
                       relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint? {
        superview?.constraints.first(where: {
            ($0.firstItem  as? UIView == self && $0.firstAttribute  == attribute ||
                $0.secondItem as? UIView == self && $0.secondAttribute == attribute)
                && $0.relation == relation
        })
        
        // Test with 3 constraints changing during 5 seconds
        // getConstraints:    107663058 - 104626723
        // Defined variables:  88937977 -  87764903
        // Time lost 0.01779345s
    }
    
    // MARK: - Alerts

    #if DEBUG
    
    func showNotImplementedAlert() {
        rootVC?.showNotImplementedAlert()
    }
    
    func showAlert(title: String, message: String?) {
        rootVC?.showAlert(title: title, message: message)
    }
    
    var rootVC: UIViewController? {
        UIApplication.shared.windows.first?.rootViewController
    }
    
    #endif
}
