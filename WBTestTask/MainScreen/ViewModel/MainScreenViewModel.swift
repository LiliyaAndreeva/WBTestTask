//
//  MainScreenViewModel.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

@MainActor
final class MainScreenViewModel: ObservableObject {
	@Published var state: MainScreenState = .loading
	
	private let service: ProductServiceProtocol
	
	init(service: ProductServiceProtocol/* = ProductService()*/) {
		self.service = service
	}
	
	func fetchProducts() async {
		state = .loading
		
		do {
			let products = try await service.fetchProducrts()
			print(products.count)
			if products.isEmpty {
				state = .empty
			} else {
				state = .loaded(products)
			}
		} catch {
			state = .error("Не удалось загрузить")
		}
	}
	
	func copyArticle(product: Product) {
		UIPasteboard.general.string = product.sku
	}
}
