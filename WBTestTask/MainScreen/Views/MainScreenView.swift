//
//  MainScreen.swift
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

struct MainScreenView: View {
	@StateObject private var viewModel = MainScreenViewModel(service: ProductService())
	
	var body: some View {
		Group {
			switch viewModel.state {
			case .loading:
				LoadingView()
			case .error:
				ErrorView()
			case .empty:
				EmptyView()
			case .loaded(let products):
				ProductGridView(
					products: products,
					selectedFilter: viewModel.selectedFilter.rawValue,
					onFilterChange: { newValue in
						if let filter = MainScreenViewModel.FilterType(rawValue: newValue) {
							viewModel.selectedFilter = filter
							viewModel.applyFilter()
						}
					}
				
				)
			}
		}

		.task {
			await viewModel.fetchProducts()
		}
	}
}

#Preview {
	MainScreenView()
}
