//
//  ForgerModel.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import Foundation
// MARK: - RegisterModel
struct ForgerModel: Codable {
    let status: Bool?
    let message: String?
    let data: ForgerModelDataClass?
}

// MARK: - DataClass
struct ForgerModelDataClass: Codable {
    let email: String?
}
