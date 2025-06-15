//
//  MainScreen.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

struct MainScreenView: View {

	@StateObject private var viewModel = MainScreenViewModel(
			service: ProductService(),
			coreData: CoreDataService()
		)
	@State private var selectedProduct: Product? = nil
	@State private var showActionSheet = false

	private var selectedFilterBinding: Binding<Int> {
		Binding<Int>(
			get: { viewModel.selectedFilter.rawValue },
			set: { newRawValue in
				if let newFilter = MainScreenViewModel.FilterType(rawValue: newRawValue) {
					viewModel.selectedFilter = newFilter
					viewModel.applyFilter()
				}
			}
		)
	}
	
	
	var body: some View {
		contentView
			.navigationBarTitleDisplayMode(.inline)
			.toolbar { navigationTitleToolbar }
			.task {
				await viewModel.fetchProducts()
			}
			.confirmationDialog(
				"",
				isPresented: $showActionSheet,
				titleVisibility: .hidden
			) {
				if let product = selectedProduct {
					Button(ConstantStrings.ActionSheet.copySKU) {
						viewModel.copyArticle(product: product)
					}
					Button(ConstantStrings.ActionSheet.copyWBSKU) {
						viewModel.copyArticleWB(product: product)
					}
					Button(ConstantStrings.ActionSheet.cancel, role: .cancel) { }
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
				selectedFilter: selectedFilterBinding,
				onOptionsTap: { product in
					selectedProduct = product
					showActionSheet = true
				}
			)
		}
	}
	
	var navigationTitleToolbar: some ToolbarContent {
		ToolbarItem(placement: .principal) {
			Text(ConstantStrings.Navigation.title)
				.font(.abeezeeRegular(size: Sizes.Text.double))
				.frame(maxWidth: .infinity)
				.multilineTextAlignment(.center)
		}
	}
}

