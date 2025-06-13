//
//  ProductGridView.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

struct ProductGridView: View {
	let products: [Product]
	let selectedFilter: Int
	let onFilterChange: (Int) -> Void
	private let filters = ["Все товары", "Товары без цены"]
	
	private let colums = [
		GridItem(.flexible())
	]
	
	var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				Picker("Фильтр", selection:Binding(
					get: { selectedFilter },
				 set: { newValue in
					 onFilterChange(newValue)
				 }
				)) {
					ForEach(0..<filters.count, id: \.self) { index in
						Text(filters[index])
					}
				}
				.pickerStyle(SegmentedPickerStyle())
				.padding([.top, .horizontal])
				ScrollView {
					LazyVGrid(columns: colums, spacing: 8) {
						ForEach(products) { product in
							ProductCell(product: product)
						}
					}
					.background(Color.palletGray)
				}
			}
		}
	}
}

//#Preview {
//	ProductGridView(products: [
//		Product(
//			id: 1,
//					 title: "Test",
//					 category: "cat",
//					 sku: "Арт. 1568161689",
//					 price: 100,
//					 discountPercentage: 10,
//					 thumbnail: ""
//				 ),
//		Product(
//			id: 1,
//					 title: "Test",
//					 category: "cat",
//					 sku: "sku",
//					 price: 100,
//					 discountPercentage: 10,
//					 thumbnail: ""
//				 ),
//		Product(
//			id: 1,
//					 title: "Test",
//					 category: "cat",
//					 sku: "sku",
//					 price: 100,
//					 discountPercentage: 10,
//					 thumbnail: ""
//				 )
//	])
//}
