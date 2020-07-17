//
//  Pin.swift
//  AnyTask
//
//  Created by Anton Tolstov on 17.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

struct Pin {
    
    // MARK: - Properties
    
    private weak var view: UIView?
    
    private(set) var constraints = [NSLayoutConstraint]()
    
    // MARK: - Initializers
    
    init(view: UIView) {
        self.view = view
    }
    
    private init(view: UIView?, constraints: [NSLayoutConstraint]) {
        self.view = view
        self.constraints = constraints
    }
    
    // MARK: - Constraint appending functions
            
    private func addConstraint<Axis, Anchor> (to otherView: UIView?,
                                              _ path: KeyPath<UIView, Anchor>,
                                              with relation: Relation,
                                              constant: CGFloat)
        -> Pin where Anchor: NSLayoutAnchor<Axis> {
            return addConstraint(toView: otherView, from: path, to: path,
                                 with: relation, constant: constant)
    }
    
    private func addConstraint<Axis, Anchor> (toView otherView: UIView?,
                                              from: KeyPath<UIView, Anchor>,
                                              to: KeyPath<UIView, Anchor>,
                                              with relation: Relation,
                                              constant: CGFloat)
        -> Pin where Anchor: NSLayoutAnchor<Axis> {
            guard let view = view, let otherView = otherView ?? view.superview else { return self }
            
            switch relation {
            case .equal:
                return add(view[keyPath: from]
                    .constraint(equalTo: otherView[keyPath: to], constant: constant))
            case .less:
                return add(view[keyPath: from]
                    .constraint(lessThanOrEqualTo: otherView[keyPath: to], constant: -constant))
            case .greater:
                return add(view[keyPath: from]
                    .constraint(greaterThanOrEqualTo: otherView[keyPath: to], constant: constant))
            }
    }
    
    private func addConstraint<D: NSLayoutDimension>(_ path: KeyPath<UIView, D>,
                                                     with relation: Relation,
                                                     constant: CGFloat) -> Pin {
        guard let view = view else { return self }
        
        switch relation {
        case .equal:
            return add(view[keyPath: path].constraint(equalToConstant: constant))
        case .less:
            return add(view[keyPath: path].constraint(lessThanOrEqualToConstant: constant))
        case .greater:
            return add(view[keyPath: path].constraint(greaterThanOrEqualToConstant: constant))
        }
    }
    
    private func addConstraint<D: NSLayoutDimension>(_ from: KeyPath<UIView, D>,
                                                     _ to: KeyPath<UIView, D>,
                                                     with relation: Relation,
                                                     multiplier: CGFloat) -> Pin {
        guard let view = view else { return self }
        
        switch relation {
        case .equal:
            return add(view[keyPath: from].constraint(equalTo: view[keyPath: to],
                                                      multiplier: multiplier))
        case .less:
            return add(view[keyPath: from].constraint(lessThanOrEqualTo: view[keyPath: to],
                                                      multiplier: multiplier))
        case .greater:
            return add(view[keyPath: from].constraint(greaterThanOrEqualTo: view[keyPath: to],
                                                      multiplier: multiplier))
        }
    }
    
    // MARK: - Relation Enum
    
    enum Relation {
        case equal
        case less
        case greater
    }
}

// MARK: - Public Interface

extension Pin {
    
    // MARK: - Edges
        
    func top(to other: UIView? = nil, be relation: Relation = .equal,
             _ constant: CGFloat = 0) -> Pin {
        addConstraint(to: other, \.topAnchor, with: relation, constant: constant)
    }
    
    func left(to other: UIView? = nil, be relation: Relation = .equal,
              _ constant: CGFloat = 0) -> Pin {
        addConstraint(to: other, \.leftAnchor, with: relation, constant: constant)
    }
    
    func right(to other: UIView? = nil, be relation: Relation = .equal,
               _ constant: CGFloat = 0) -> Pin {
        addConstraint(to: other, \.rightAnchor, with: relation, constant: -constant)
    }
    
    func bottom(to other: UIView? = nil, be relation: Relation = .equal,
                _ constant: CGFloat = 0) -> Pin {
        addConstraint(to: other, \.bottomAnchor, with: relation, constant: -constant)
    }
    
    // MARK: - Convenience shortcuts
    
    func sides(to other: UIView? = nil, be relation: Relation = .equal,
               _ constant: CGFloat = 0) -> Pin {
        self.left(to: other, be: relation, constant)
            .right(to: other, be: relation, constant)
    }
    
    func topBottom(to other: UIView? = nil, be relation: Relation = .equal,
                   _ constant: CGFloat = 0) -> Pin {
        self.top(to: other, be: relation, constant)
            .bottom(to: other, be: relation, constant)
    }
    
    func all(to other: UIView? = nil, be relation: Relation = .equal,
             _ constant: CGFloat = 0) -> Pin {
        self.sides(to: other, be: relation, constant)
            .topBottom(to: other, be: relation, constant)
    }
    
    func all(to other: UIView? = nil, be relation: Relation = .equal,
             insets: UIEdgeInsets) -> Pin {
        self.top(to: other, be: relation, insets.top)
            .left(to: other, be: relation, insets.left)
            .right(to: other, be: relation, insets.right)
            .bottom(to: other, be: relation, insets.bottom)
    }
    
    // MARK: - Edges relative to other views
    
    func below(_ other: UIView, be relation: Relation = .equal,
               _ constant: CGFloat = 0) -> Pin {
        addConstraint(toView: other, from: \.topAnchor,  to: \.bottomAnchor,
                      with: relation, constant: constant)
    }
    
    func above(_ other: UIView, be relation: Relation = .equal,
               _ constant: CGFloat = 0) -> Pin {
        addConstraint(toView: other, from: \.bottomAnchor, to: \.topAnchor,
                      with: relation, constant: -constant)
    }
    
    func before(_ other: UIView, be relation: Relation = .equal,
                _ constant: CGFloat = 0) -> Pin {
        addConstraint(toView: other, from: \.rightAnchor, to: \.leftAnchor,
                      with: relation, constant: constant)
    }
    
    func after(_ other: UIView, be relation: Relation = .equal,
               _ constant: CGFloat = 0) -> Pin {
        addConstraint(toView: other, from: \.leftAnchor, to: \.rightAnchor,
                      with: relation, constant: constant)
    }
    
    // MARK: - Width, height and size
    
    func height(be relation: Relation = .equal, _ constant: CGFloat) -> Pin {
        addConstraint(\.heightAnchor, with: relation, constant: constant)
    }
    
    func width(be relation: Relation = .equal, _ constant: CGFloat) -> Pin {
        addConstraint(\.widthAnchor, with: relation, constant: constant)
    }
    
    func size(be relation: Relation = .equal, _ constant: CGFloat) -> Pin {
        width(be: relation, constant).height(be: relation, constant)
    }
    
    func size(be relation: Relation = .equal, _ constant: CGSize) -> Pin {
        width(be: relation, constant.width).height(be: relation, constant.height)
    }
    
    // MARK: - Aspect ratio (width / height)
    
    func aspectRatio(be relation: Relation = .equal, _ multiplier: CGFloat) -> Pin {
        addConstraint(\.heightAnchor, \.widthAnchor, with: relation, multiplier: multiplier)
    }
    
    // MARK: - Center
    
    func hCenter(of other: UIView? = nil, be relation: Relation = .equal,
                 _ constant: CGFloat = 0) -> Pin {
        addConstraint(to: other, \.centerXAnchor, with: relation, constant: constant)
    }
    
    func vCenter(of other: UIView? = nil, be relation: Relation = .equal,
                 _ constant: CGFloat = 0) -> Pin {
        addConstraint(to: other, \.centerYAnchor, with: relation, constant: constant)
    }
    
    func center(of other: UIView? = nil, be relation: Relation = .equal,
                _ constant: CGFloat = 0) -> Pin {
        self.hCenter(of: other, be: relation, constant)
            .vCenter(of: other, be: relation, constant)
    }
       
    // MARK: - Existing constraints
    
    func add(_ constraint: NSLayoutConstraint) -> Pin {
        return Pin(view: view, constraints: constraints + [constraint])
    }
    
    func add(_ constraints: [NSLayoutConstraint]) -> Pin {
        return Pin(view: view, constraints: self.constraints.withAppend(contentsOf: constraints))
    }
    
    // MARK: - Activation
    
    var activate: Void {
        view?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Safe Area Public Interface

extension Pin {
    
    // MARK: - Safe Area Edges
    
    func topSafe(to other: UIView? = nil, be relation: Relation = .equal,
             _ constant: CGFloat = 0) -> Pin {
        if #available(iOS 11.0, *) {
            return addConstraint(to: other, \.safeAreaLayoutGuide.topAnchor,
                                 with: relation, constant: constant)
        } else {
            // TODO: Fix for iOS 10
            return top(to: other, be: relation, constant)
        }
    }
    
    func leftSafe(to other: UIView? = nil, be relation: Relation = .equal,
             _ constant: CGFloat = 0) -> Pin {
        if #available(iOS 11.0, *) {
            return addConstraint(to: other, \.safeAreaLayoutGuide.leftAnchor,
                                 with: relation, constant: constant)
        } else {
            // TODO: Fix for iOS 10
            return left(to: other, be: relation, constant)
        }
    }
    
    func rightSafe(to other: UIView? = nil, be relation: Relation = .equal,
             _ constant: CGFloat = 0) -> Pin {
        if #available(iOS 11.0, *) {
            return addConstraint(to: other, \.safeAreaLayoutGuide.rightAnchor,
                                 with: relation, constant: -constant)
        } else {
            // TODO: Fix for iOS 10
            return right(to: other, be: relation, constant)
        }
    }
    
    func bottomSafe(to other: UIView? = nil, be relation: Relation = .equal,
             _ constant: CGFloat = 0) -> Pin {
        if #available(iOS 11.0, *) {
            return addConstraint(to: other, \.safeAreaLayoutGuide.bottomAnchor,
                                 with: relation, constant: -constant)
        } else {
            // TODO: Fix for iOS 10
            return bottom(to: other, be: relation, constant)
        }
    }
    
    // MARK: - Safe Area Convenience shortcuts
    
    func sidesSafe(to other: UIView? = nil, be relation: Relation = .equal,
               _ constant: CGFloat = 0) -> Pin {
        if #available(iOS 11.0, *) {
            return self.leftSafe(to: other, be: relation, constant)
                       .rightSafe(to: other, be: relation, constant)
        } else {
            // TODO: Fix for iOS 10
            return sides(to: other, be: relation, constant)
        }
    }
    
    func topBottomSafe(to other: UIView? = nil, be relation: Relation = .equal,
                   _ constant: CGFloat = 0) -> Pin {
        if #available(iOS 11.0, *) {
            return self.topSafe(to: other, be: relation, constant)
                       .bottomSafe(to: other, be: relation, constant)
        } else {
            // TODO: Fix for iOS 10
            return topBottom(to: other, be: relation, constant)
        }
    }
    
    func allSafe(to other: UIView? = nil, be relation: Relation = .equal,
             _ constant: CGFloat = 0) -> Pin {
        if #available(iOS 11.0, *) {
            return self.sidesSafe(to: other, be: relation, constant)
                       .topBottomSafe(to: other, be: relation, constant)
        } else {
            // TODO: Fix for iOS 10
            return all(to: other, be: relation, constant)
        }
    }
}

// MARK: - UIView pin extension

extension UIView {
    var pin: Pin {
        return Pin(view: self)
    }
}
