//
//  CoreDataServiceTests.swift
//  WBTestTaskTests
//
//  Created by Лилия Андреева on 14.06.2025.
//

import XCTest
import CoreData
@testable import WBTestTask

final class CoreDataServiceTests: XCTestCase {

	var coreDataService: CoreDataService!

	override func setUp() {
		super.setUp()
		coreDataService = CoreDataService(inMemory: true)
	}

	override func tearDown() {
		coreDataService = nil
		super.tearDown()
	}

	func testSaveAndFetchProducts() throws {
		let products = [
			Product(id: 1, title: "Test 1", category: "Category 1", sku: "SKU1", price: 10.0, discountPercentage: 5.0, thumbnail: "url1"),
			Product(id: 2, title: "Test 2", category: "Category 2", sku: "SKU2", price: 20.0, discountPercentage: 10.0, thumbnail: "url2")
		]

		try coreDataService.saveProducts(products)
		let fetched = try coreDataService.fetchStoredProducts()

		XCTAssertEqual(fetched.count, 2)
		XCTAssertEqual(fetched[0].title, "Test 1")
		XCTAssertEqual(fetched[1].sku, "SKU2")
	}

	func testSaveProductsOverridesOldOnes() throws {
		let products1 = [
			Product(id: 1, title: "Old", category: "OldCat", sku: "OLD", price: 5.0, discountPercentage: 2.0, thumbnail: "oldurl")
		]
		try coreDataService.saveProducts(products1)

		let products2 = [
			Product(id: 2, title: "New", category: "NewCat", sku: "NEW", price: 15.0, discountPercentage: 3.0, thumbnail: "newurl")
		]
		try coreDataService.saveProducts(products2)

		let fetched = try coreDataService.fetchStoredProducts()

		XCTAssertEqual(fetched.count, 1)
		XCTAssertEqual(fetched[0].id, 2)
		XCTAssertEqual(fetched[0].title, "New")
	}

	
	func testSaveContextWithoutChangesDoesNotThrow() throws {
		XCTAssertNoThrow(try coreDataService.saveContext())
	}
}
