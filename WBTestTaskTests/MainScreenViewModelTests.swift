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
	
	func testFetchProducts_success() async {
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
}
