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
	private let coreData: CoreDataService
	private var products: [Product] = []
	
	enum FilterType: Int {
		case all
		case withoutPrice
	}

	init(service: ProductServiceProtocol, coreData: CoreDataService = .shared) {
		self.service = service
		self.coreData = coreData
	}

	func fetchProducts() async {
		state = .loading
		selectedFilter = .all

		do {
			let loaded = try await service.fetchProducrts()
			products = loaded
			state = loaded.isEmpty ? .empty : .loaded(loaded)

			try? coreData.saveProducts(loaded)
		} catch {
			do {
				let cached = try coreData.fetchStoredProducts()
				products = cached
				state = cached.isEmpty ? .error("Нет данных") : .loaded(cached)
			} catch {
				state = .error("Ошибка загрузки данных из памяти")
			}
		}
	}

	func copyArticle(product: Product) {
		UIPasteboard.general.string = product.sku
	}

	func copyArticleWB(product: Product) {
		UIPasteboard.general.string = product.wbSku
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

private extension MainScreenViewModel {
	func filterProduct(produсts: [Product]) -> [Product] {
		let filterProducts = products.filter{ $0.price == 0 }
		return filterProducts
	}
}
