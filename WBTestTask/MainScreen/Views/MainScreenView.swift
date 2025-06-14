//
//  MainScreen.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

struct MainScreenView: View {
	@StateObject private var viewModel = MainScreenViewModel(service: ProductService())
	
	var body: some View {
		contentView
			.navigationBarTitleDisplayMode(.inline)
			.toolbar { navigationTitleToolbar }
			.task { await viewModel.fetchProducts() }
			.onAppear{ for family in UIFont.familyNames.sorted() {
				print("📁 Font family: \(family)")
				for name in UIFont.fontNames(forFamilyName: family) {
					print("    🧷 Font name: \(name)")
				}
			}
		}
	}
}


private extension MainScreenView {
	@ViewBuilder
	var contentView: some View {
		switch viewModel.state {
		case .loading:
			LoadingView()
		case .error:
			ErrorView(onRetry: {
				Task {
					await viewModel.fetchProducts()
				}
			})
		case .empty:
			EmptyView()
				.onAppear {
					DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
						Task {
							await viewModel.fetchProducts()
						}
					}
				}
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
	
	var navigationTitleToolbar: some ToolbarContent {
		ToolbarItem(placement: .principal) {
			Text("Цены и скидки")
				.font(.abeezeeRegular(size: 18))
				.frame(maxWidth: .infinity)
				.multilineTextAlignment(.center)
		}
	}
}

#Preview {
	MainScreenView()
}
