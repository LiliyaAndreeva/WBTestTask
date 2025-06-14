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
	var container: NSPersistentContainer!

	override func setUp() {
		super.setUp()
		
		container = NSPersistentContainer(name: "WBTestTask")
		let description = NSPersistentStoreDescription()
		description.type = NSInMemoryStoreType
		container.persistentStoreDescriptions = [description]

		coreDataService = CoreDataService(container: container)
	}

	override func tearDown() {
		coreDataService = nil
		container = nil
		super.tearDown()
	}

	func testAddItem() throws {
		try coreDataService.addItem()
		
		let items = try coreDataService.fetchItems()
		XCTAssertEqual(items.count, 1, "Должен добавиться 1 объект")
		XCTAssertNotNil(items.first?.timestamp, "Timestamp не должен быть nil")
	}

	func testFetchItemsSorted() throws {
		let context = coreDataService.viewContext
		
		let item1 = Item(context: context)
		item1.timestamp = Date(timeIntervalSince1970: 1000)
		
		let item2 = Item(context: context)
		item2.timestamp = Date(timeIntervalSince1970: 500)
		
		let item3 = Item(context: context)
		item3.timestamp = Date(timeIntervalSince1970: 1500)
		
		try coreDataService.saveContext()
		
		let fetched = try coreDataService.fetchItems()
		let timestamps = fetched.compactMap { $0.timestamp?.timeIntervalSince1970 }
		
		XCTAssertEqual(timestamps, timestamps.sorted())
	}

	func testDeleteItem() throws {
		try coreDataService.addItem()
		var items = try coreDataService.fetchItems()
		XCTAssertEqual(items.count, 1)

		let item = items.first!
		try coreDataService.delete(item: item)
		
		items = try coreDataService.fetchItems()
		XCTAssertEqual(items.count, 0, "После удаления не должно остаться элементов")
	}
	
	func testSaveContextWithoutChangesDoesNotThrow() throws {
		XCTAssertNoThrow(try coreDataService.saveContext())
	}
}
