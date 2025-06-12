//
//  ProductGridView.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

struct ProductGridView: View {
	let products: [Product]
	let onCopy: (Product) -> Void

	private let columns = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]

	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns, spacing: 16) {
				ForEach(products) { product in
					ProductCell(product: product)
						.onTapGesture {
							onCopy(product)
						}
				}
			}
			.padding()
		}
	}
}
