//
//  IdentifiableObject.swift
//  AnyTask
//
//  Created by Anton Tolstov on 30.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

protocol IdentifiableObject {
    associatedtype IdentityType
    
    var id: IdentityType { get }
}
