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
		VStack(alignment: .leading, spacing: 0) {
			HStack(alignment: .center, spacing: 12) {
				KFImage(URL(string: product.thumbnail))
					.placeholder {
						ProgressView()
					}
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 84, height: 116)
					.clipped()
				VStack(alignment: .leading, spacing: 4) {
					HStack {
						Text(product.category)
							.font(.customRegular(size: 14))
							.frame(width: 81, height: 24)
							.background(Color.gray.opacity(0.2))
							.cornerRadius(6)
						Spacer()
						Button {
							
						} label: {
							Image(systemName: "ellipsis")
								.foregroundColor(.primary)
								.frame(width: 32, height: 32)
								.background(Color.gray.opacity(0.2))
								.cornerRadius(12)
						}
					}
					Text(product.title)
						.font(.customRegular(size: 16).bold())
					VStack(alignment: .leading, spacing: 2) {
						Text(product.sku)
							.font(.customRegular(size: 14))
							.opacity(0.6)
						Text(product.wbSku)
							.font(.customRegular(size: 14))
							.opacity(0.6)
					}
					
					
					Spacer()
					
				}
			}
			.padding(.horizontal, 12)
			.padding([.bottom, .top], 18)
			
			VStack(spacing: 8) {
				ForEach(
						[("Цена продавца до скидки", "\(Int(product.price)) ₽"),
						 ("Скидка продавца", "\(Int(product.discountPercentage)) %"),
						 ("Цена со скидкой", "\(Int(product.discountedPrice)) ₽")],
						id: \.0
					) { title, value in
						priceRow(title: title, value: value)
					}
			}
			.padding(.horizontal, 12)
			.padding(.bottom, 18)
		}
		.background(.white)
		.cornerRadius(16)
	}
}
private extension ProductCell {
	@ViewBuilder
	private func priceRow(title: String, value: String) -> some View {
		GeometryReader { geometry in
			let font = UIFont.systemFont(ofSize: 14, weight: .regular)
			let titleWidth = title.width(usingFont: font)
			let valueWidth = value.width(usingFont: font)
			
			let availableWidth = max(0, geometry.size.width - titleWidth - valueWidth - 16)
			let underlineCharWidth = "_".width(usingFont: UIFont.monospacedSystemFont(ofSize: 14, weight: .regular))

			let underlineCount = max(3, Int(availableWidth / underlineCharWidth))
			let underlineString = String(repeating: "_", count: underlineCount)
			
			HStack() {
				Text(title)
					.font(.customRegular(size: 14))
					.foregroundStyle(Color.semanticColorText)
					.fixedSize()
					.frame(width: titleWidth, alignment: .leading)

				Text(underlineString)
					.font(.system(size: 14, design: .monospaced))
					.foregroundStyle(Color.semanticColorText)
					.fixedSize()
					.frame(width: availableWidth, alignment: .center)

				
				Text(value)
					.font(.customRegular(size: 14))
					.fixedSize()
					.frame(width: valueWidth, alignment: .trailing)
					
			}
			.frame(width: geometry.size.width, alignment: .leading)
		}
		.frame(height: 20)
	}
}

#Preview {
	ProductCell(product: Product(
		id: 1,
				 title: "Test",
				 category: "cat",
				 sku: "Арт. 1568161689",
				 price: 100,
				 discountPercentage: 10,
				 thumbnail: ""
			 ))
}

private extension String {
	func width(usingFont font: UIFont) -> CGFloat {
		let attributes = [NSAttributedString.Key.font: font]
		let size = (self as NSString).size(withAttributes: attributes)
		return size.width
	}
}
