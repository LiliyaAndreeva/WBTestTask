//
//  ProductGridView.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

struct ProductGridView: View {
	let products: [Product]
	@Binding var selectedFilter: Int
	let onOptionsTap: (Product) -> Void
	private let filters = [ConstantStrings.Filter.all, ConstantStrings.Filter.withoutPrice]
	
	private let colums = [
		GridItem(.flexible())
	]
	
	var body: some View {
		VStack(alignment: .leading) {
			Picker(ConstantStrings.Filter.pickerTitle, selection: $selectedFilter) {
				ForEach(0..<filters.count, id: \.self) { index in
					Text(filters[index])
				}
			}
			.pickerStyle(SegmentedPickerStyle())
			.padding([.top, .horizontal])
			ScrollView {
				LazyVGrid(columns: colums, spacing: Sizes.Padding.small) {
					ForEach(products) { product in
						ProductCell(product: product, onOptionsTap: {
							onOptionsTap(product)
						})
					}
				}
				.background(Color.palletGray)
			}
		}
	}
}

