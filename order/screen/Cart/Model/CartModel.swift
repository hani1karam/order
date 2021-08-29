//
//  CartModel.swift
//  order
//
//  Created by hany karam on 8/28/21.
//

import Foundation
struct ShowCart: Codable {
    let status: Bool?
    let message: String?
    let data: ShowCartDataClass?
}

// MARK: - DataClass
struct ShowCartDataClass: Codable {
    let cartItems: [CartItem]?
    let subTotal, total: Int?

    enum CodingKeys: String, CodingKey {
        case cartItems = "cart_items"
        case subTotal = "sub_total"
        case total
    }
}

// MARK: - CartItem
struct CartItem: Codable {
    let id, quantity: Int?
    let product: CartItemProduct?
}

// MARK: - Product
struct CartItemProduct: Codable {
    let id, price, oldPrice, discount: Double?
    let image: String?
    let name, productDescription: String?
    let images: [String]?
    let inFavorites, inCart: Bool?

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
        case images
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}

