//
//  MainScreenViewModelTests.swift
//  WBTestTaskTests
//
//  Created by Лилия Андреева on 12.06.2025.
//

import Foundation
@testable import WBTestTask
import XCTest


final class MainScreenViewModelTests: XCTestCase {

	func testFetchProductsSuccess() async {
		let mockService = ProductServiceMock()
		mockService.result = .success(
			[
				Product(
					id: 1,
					title: "Test",
					category: "cat",
					sku: "sku",
					price: 100,
					discountPercentage: 10,
					thumbnail: ""
				)
			]
		)

		let viewModel = await MainScreenViewModel(service: mockService)

		await viewModel.fetchProducts()

		switch await viewModel.state {
		case .loaded(let products):
			XCTAssertEqual(products.count, 1)
		default:
			XCTFail("State should be loaded")
		}
	}

	func testFetchProductsFail() async {
		let mockService = ProductServiceMock()
		mockService.result = .failure(MockError.someError)

		let viewModel = await MainScreenViewModel(service: mockService)

		await viewModel.fetchProducts()

		switch await viewModel.state {
		case .error(let message):
			XCTAssertEqual(message, "Не удалось загрузить")
		default:
			XCTFail("State should be error")
		}
	}

	func testFetchProductsEmpty() async {
		let mockService = ProductServiceMock()
		mockService.result = .success([])

		let viewModel = await MainScreenViewModel(service: mockService)

		await viewModel.fetchProducts()

		switch await viewModel.state {
		case .empty:
			XCTAssert(true)
		default:
			XCTFail("State should be empty")
		}
	}
	
	func testApplyFilterWithoutPrice() async {
		let mockService = ProductServiceMock()

		mockService.result = .success(
			[
				Product(
					id: 1,
					title: "Test",
					category: "cat",
					sku: "sku",
					price: 100,
					discountPercentage: 10,
					thumbnail: ""
				),
				Product(
					id: 1,
					title: "Test2",
					category: "cat",
					sku: "sku",
					price: 0,
					discountPercentage: 10,
					thumbnail: ""
				)
			]
		)

		let viewModel = await MainScreenViewModel(service: mockService)
		await viewModel.fetchProducts()
		
		await MainActor.run {
			viewModel.selectedFilter = .withoutPrice
			viewModel.applyFilter()
		}

		switch await viewModel.state {
		case .loaded(let filtered):
			XCTAssertEqual(filtered.count, 1)
			XCTAssertEqual(filtered.first?.price, 0)
		default:
			XCTFail("Expected filtered state")
		}
	}

	func testApplyFilterAll() async {
		let mockService = ProductServiceMock()

		let products = [
			Product(id: 1, title: "One", category: "cat", sku: "sku", price: 0, discountPercentage: 0, thumbnail: ""),
			Product(id: 2, title: "Two", category: "cat", sku: "sku2", price: 100, discountPercentage: 0, thumbnail: "")
		]
		mockService.result = .success(products)

		let viewModel = await MainScreenViewModel(service: mockService)
		await viewModel.fetchProducts()

		await MainActor.run {
			viewModel.selectedFilter = .all
			viewModel.applyFilter()
		}

		switch await viewModel.state {
		case .loaded(let result):
			XCTAssertEqual(result.count, products.count)
		default:
			XCTFail("Expected all products")
		}
	}
	
	func testCopyArticleSetsPasteboard() async {
		let mockService = ProductServiceMock()
		let viewModel = await MainScreenViewModel(service: mockService)

		let product = Product(
			id: 1,
			title: "Test",
			category: "cat",
			sku: "SKU123",
			price: 0,
			discountPercentage: 0,
			thumbnail: ""
		)

		await viewModel.copyArticle(product: product)

		XCTAssertEqual(UIPasteboard.general.string, "SKU123")
	}

	func testCopyArticleWBSetsPasteboard() async {
		let mockService = ProductServiceMock()
		let viewModel = await MainScreenViewModel(service: mockService)
		
		let product = Product(
			id: 1,
			title: "Test",
			category: "cat",
			sku: "SKU123",
			price: 0,
			discountPercentage: 0,
			thumbnail: ""
		)
		
		await viewModel.copyArticleWB(product: product)
		
		XCTAssertEqual(UIPasteboard.general.string, "WB-SKU123")
	}
	
	func testFetchProductsInNetworkSuccess() async throws {
		let mock = NetworkServiceMock()
		mock.mockResponse = ProductsResponse(products: [Product(
			id: 1,
			title: "Test",
			category: "cat",
			sku: "SKU123",
			price: 0,
			discountPercentage: 0,
			thumbnail: ""
		)])

		let service = ProductService(networkService: mock)
		let products = try await service.fetchProducrts()

		XCTAssertEqual(products.count, 1)
		XCTAssertEqual(products.first?.title, "Test")
	}
}
