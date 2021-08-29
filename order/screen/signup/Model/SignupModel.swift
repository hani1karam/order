//
//  SignupModel.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import Foundation
struct RegisterModel: Codable {
    let status: Bool?
    let message: String?
    let data: RegisterModelDataClass?
}

// MARK: - DataClass
struct RegisterModelDataClass: Codable {
    let name, phone, email: String?
    let id: Int?
    let image: String?
    let token: String?
}
