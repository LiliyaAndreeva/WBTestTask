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
				fatalError("❌ CoreData error: \(error.localizedDescription)")
			}
		}
	}

	// MARK: - CRUD

	func fetchItems() throws -> [Item] {
		let request: NSFetchRequest<Item> = Item.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)]
		return try viewContext.fetch(request)
	}

	func addItem() throws {
		let newItem = Item(context: viewContext)
		newItem.timestamp = Date()
		try saveContext()
	}

	func delete(item: Item) throws {
		viewContext.delete(item)
		try saveContext()
	}

	func saveContext() throws {
		if viewContext.hasChanges {
			try viewContext.save()
		}
	}
}
