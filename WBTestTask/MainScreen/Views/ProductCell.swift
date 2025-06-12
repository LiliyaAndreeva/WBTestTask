//
//  ProductCell.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI
import Kingfisher


struct ProductCell: View {
	let product: Product

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			KFImage(URL(string: product.thumbnail))
				.placeholder {
					ProgressView()
				}
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(height: 120)
				.clipped()
				.frame(height: 120)
				.clipped()
			Text(product.title)
				.font(.headline)
				.lineLimit(2)
			Text("Категория: \(product.category)")
				.font(.subheadline)
				.foregroundColor(.secondary)
			Text("Артикул: \(product.sku)")
				.font(.caption)
				.foregroundColor(.gray)
			Text("Цена: \(String(format: "%.2f", product.price)) ₽")
				.font(.subheadline)
			Text("Скидка: \(String(format: "%.1f", product.discountPercentage))%")
				.font(.caption)
				.foregroundColor(.green)
			Text("Цена со скидкой: \(String(format: "%.2f", product.discountedPrice)) ₽")
				.font(.headline)
				.foregroundColor(.blue)
		}
		.padding()
		.background(Color(.systemBackground))
		.cornerRadius(12)
		.shadow(radius: 2)
	}
}
