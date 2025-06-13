//
//  MainScreenViewModel.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

enum MainScreenState {
	case loading
	case error(String)
	case empty
	case loaded([Product])
}

@MainActor
final class MainScreenViewModel: ObservableObject {
	@Published var state: MainScreenState = .loading
	@Published var selectedFilter: FilterType = .all
	
	private let service: ProductServiceProtocol
	private var products: [Product] = []
	
	enum FilterType: Int {
		case all
		case withoutPrice
	}

	
	init(service: ProductServiceProtocol) {
		self.service = service
	}
	
	func fetchProducts() async {
		state = .loading
		
		do {
			products = try await service.fetchProducrts()
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
	
	func filterProduct(produсts: [Product]) -> [Product] {
		let filterProducts = products.filter{ $0.price == 0 }
		return filterProducts
	}
	
	func applyFilter() {
		switch selectedFilter {
		case .all:
			state = .loaded(products)
		case .withoutPrice:
			let filtered = filterProduct(produсts: products)
			state = filtered.isEmpty ? .empty : .loaded(filtered)
		}
	}
}
