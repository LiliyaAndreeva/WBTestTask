//
//  ProductServiceMoc.swift
//  WBTestTaskTests
//
//  Created by Лилия Андреева on 12.06.2025.
//


import Foundation
@testable import WBTestTask

final class ProductServiceMock: ProductServiceProtocol {
	var result: Result<[Product], Error> = .success([])

	func fetchProducrts() async throws -> [Product] {
		switch result {
		case .success(let products):
			return products
		case .failure(let error):
			throw error
		}
	}
}
