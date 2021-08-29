//
//  AddCartModel.swift
//  order
//
//  Created by hany karam on 8/28/21.
//

import Foundation
struct AddCartModel: Codable {
    let status: Bool?
    let message: String?
    let data: AddCartModelDataClass?
}

// MARK: - DataClass
struct AddCartModelDataClass: Codable {
    let id, quantity: Int?
    let product: Product?
}

// MARK: - Product
struct Product: Codable {
    let id, price, oldPrice, discount: Int?
    let image: String?
    let name, productDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
    }
}
