//
//  ContentView.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

struct ContentView: View {

	private let viewContext = CoreDataService.shared.viewContext

	var body: some View {
		NavigationView {
			MainScreenView()
				.environment(\.managedObjectContext, viewContext)
		}
	}
}



