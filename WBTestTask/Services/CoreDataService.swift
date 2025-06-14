//
//  CoreDataService.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 14.06.2025.
//

import Foundation
import CoreData

final class CoreDataService {
	static let shared = CoreDataService()

	private let container: NSPersistentContainer

	var viewContext: NSManagedObjectContext {
		container.viewContext
	}

	private init() {
		container = NSPersistentContainer(name: "WBTestTask")
		container.loadPersistentStores { description, error in
			if let error = error {
				fatalError("CoreData error: \(error.localizedDescription)")
			}
		}
	}
	
	init(container: NSPersistentContainer) {
		self.container = container
	}

	func fetchItems() throws -> [CDProduct] {
		let request: NSFetchRequest<CDProduct> = CDProduct.fetchRequest()
		return try viewContext.fetch(request)
	}

	func saveContext() throws {
		if viewContext.hasChanges {
			try viewContext.save()
		}
	}

	func saveProducts(_ products: [Product]) throws {

		let existingItems = try fetchItems()
		for item in existingItems {
			viewContext.delete(item)
		}

		for product in products {
			let item = CDProduct(context: viewContext)
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
