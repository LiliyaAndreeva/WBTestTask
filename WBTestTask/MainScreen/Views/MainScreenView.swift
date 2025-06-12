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
	@StateObject private var viewModel = MainScreenViewModel()
	
	var body: some View {
		Group {
			switch viewModel.state {
			case .loading:
				LoadingView()
			case .error(let string):
				ErrorView()
			case .empty:
				EmptyView()
			case .loaded(let products):
				ProductGridView(products: products) { product in
					viewModel.copyArticle(product: product)
				}
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
