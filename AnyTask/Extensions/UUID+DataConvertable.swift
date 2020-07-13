//
//  UUID+DataConvertable.swift
//  AnyTask
//
//  Created by Anton Tolstov on 13.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import Foundation

extension UUID {
    var data: Data { withUnsafeBytes(of: uuid) { Data($0) } }
}

extension Data {
    func unsafeUUID() -> UUID { withUnsafeBytes { $0.load(as: UUID.self) } }
}
