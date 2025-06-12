//
//  Product.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import Foundation


struct ProductsResponse: Decodable {
	let products: [Product]
}

struct Product: Identifiable, Decodable {
	let id: Int
	let title: String
	let category: String
	let sku: String
	let price: Double
	let discountPercentage: Double
	let thumbnail: String

	var wbSku: String {
		"WB-\(sku)"
	}

	var discountedPrice: Double {
		price * (1 - discountPercentage / 100)
	}
}
