//
//  CoreDataService.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 14.06.2025.
//

import Foundation
import CoreData

final class CoreDataService {
	//static let shared = CoreDataService()

	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext

	var viewContext: NSManagedObjectContext {
		context
	}
	
	init(inMemory: Bool = false) {
		container = NSPersistentContainer(name: "WBTestTask")
		
		if inMemory {
			let description = NSPersistentStoreDescription()
			description.type = NSInMemoryStoreType
			container.persistentStoreDescriptions = [description]
		}

		let semaphore = DispatchSemaphore(value: 0)
		container.loadPersistentStores { _, error in
			if let error = error {
				fatalError("❌ Failed to load store: \(error)")
			}
			semaphore.signal()
		}
		semaphore.wait()

		context = container.viewContext
		context.automaticallyMergesChangesFromParent = true
		context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
	}

//	private init() {
//		container = NSPersistentContainer(name: "WBTestTask")
//		container.loadPersistentStores { description, error in
//			if let error = error {
//				fatalError("CoreData error: \(error.localizedDescription)")
//			}
//		}
//	}
//	
//	init(container: NSPersistentContainer) {
//		self.container = container
//	}

	func fetchItems() throws -> [CDProduct] {
		let request: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
		return try context.fetch(request)
	}

	func saveContext() throws {
		if context.hasChanges {
			try context.save()
		}
	}

	func saveProducts(_ products: [Product]) throws {

		let existingItems = try fetchItems()
		for item in existingItems {
			context.delete(item)
		}

		for product in products {
			let item = CDProduct(context: context)
			item.id = Int64(product.id)
			item.title = product.title
			item.category = product.category
			item.sku = product.sku
			item.price = product.price
			item.discountPercentage = product.discountPercentage
			item.thumbnail = product.thumbnail
		}

		try saveContext()
	}
	
	func fetchStoredProducts() throws -> [Product] {
		let items = try fetchItems()
		return items.map {
			Product(
				id: Int($0.id),
				title: $0.title ?? "",
				category: $0.category ?? "",
				sku: $0.sku ?? "",
				price: $0.price,
				discountPercentage: $0.discountPercentage,
				thumbnail: $0.thumbnail ?? ""
			)
		}
	}
}
