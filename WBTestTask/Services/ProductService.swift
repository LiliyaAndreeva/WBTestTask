//
//  ProductService.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import Foundation


protocol ProductServiceProtocol {
	func fetchProducrts() async throws -> [Product]
}

final class ProductService: ProductServiceProtocol {

	private let networkService: NetworkServiceProtocol

		init(networkService: NetworkServiceProtocol = NetworkService()) {
			self.networkService = networkService
		}

	func fetchProducrts() async throws -> [Product] {
		guard let url = URL(string: "https://dummyjson.com/products") else {
			throw URLError(.badURL)
		}
		let responce = try await networkService.fetch(ProductsResponse.self, from: url)
		return responce.products

	}
}
