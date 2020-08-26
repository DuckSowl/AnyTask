//
//  Delegate.swift
//  AnyTask
//
//  Created by Anton Tolstov on 24.08.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

protocol UpdateDelegate: Delegate {
    func update()
}

protocol Delegate: AnyObject { }
