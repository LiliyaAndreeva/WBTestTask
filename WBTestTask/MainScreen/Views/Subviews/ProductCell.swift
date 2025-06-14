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
	let onOptionsTap: () -> Void

	var body: some View {
			VStack(alignment: .leading, spacing: 0) {
				topContent
				priceListView
					.padding(.horizontal, Sizes.Padding.medium)
					.padding(.bottom, Sizes.Padding.vertical)
			}
			.background(.white)
			.cornerRadius(Sizes.Radius.cornerRadius)
		}
}

private extension ProductCell {

	var topContent: some View {
		HStack(alignment: .center, spacing: Sizes.Padding.medium) {
			imageView
			VStack(alignment: .leading, spacing: Sizes.Padding.tiny) {
				HStack {
					categoryLabel
					Spacer()
					optionsButton
				}
				titleBlock
				SKUBlock
				Spacer()
			}
		}
		.padding(.horizontal, Sizes.Padding.medium)
		.padding(.vertical, Sizes.Padding.vertical)
	}

	var imageView: some View {
		KFImage(URL(string: product.thumbnail))
			.placeholder {
				ProgressView()
			}
			.resizable()
			.aspectRatio(contentMode: .fill)
			.frame(width: Sizes.Width.image, height: Sizes.Height.image)
			.clipped()
	}

	var categoryLabel: some View {
		Text(product.category)
			.font(.sfRegular(size: Sizes.Text.small))
			.frame(width: Sizes.Width.categoryLabel, height: Sizes.Height.categoryLabel)
			.background(Color.gray.opacity(Sizes.Opacity.faint))
			.cornerRadius(Sizes.Radius.badgeCornerRadius)
	}

	var optionsButton: some View {
		Button(action: onOptionsTap) {
			Image(systemName: ConstantStrings.ConstantImages.elipsisIcon)
				.foregroundColor(.primary)
				.frame(width: Sizes.optionsButtonSize, height: Sizes.optionsButtonSize)
				.background(Color.gray.opacity(Sizes.Opacity.faint))
				.cornerRadius(Sizes.Radius.buttonCornerRadius)
		}
	}

	var titleBlock: some View {
		Text(product.title)
			.font(.sfRegular(size: Sizes.Text.normal).bold())
	}

	var SKUBlock: some View {
		VStack(alignment: .leading, spacing: Sizes.Padding.micro) {
			Text("\(ConstantStrings.Product.skuPrefix) \(product.sku)")
				.font(.sfRegular(size: Sizes.Text.small))
				.opacity(Sizes.Opacity.secondaryText)
			
			Text("\(ConstantStrings.Product.wbSkuPrefix) \(product.wbSku)")
				.font(.sfRegular(size: Sizes.Text.small))
				.opacity(Sizes.Opacity.secondaryText)
		}
	}

	var priceListView: some View {
		VStack(spacing: Sizes.Padding.small) {
			ForEach(
				[
					(ConstantStrings.Price.original, "\(Int(product.price)) ₽"),
					(ConstantStrings.Price.discount, "\(Int(product.discountPercentage)) %"),
					(ConstantStrings.Price.discounted, "\(Int(product.discountedPrice)) ₽")
				],
				id: \.0
			) { title, value in
				priceRow(title: title, value: value)
			}
		}
	}

	@ViewBuilder
	func priceRow(title: String, value: String) -> some View {
		GeometryReader { geometry in
			let font = UIFont.systemFont(ofSize: Sizes.Text.small, weight: .regular)
			let titleWidth = title.width(usingFont: font)
			let valueWidth = value.width(usingFont: font)
			
			let availableWidth = max(0, geometry.size.width - titleWidth - valueWidth - 16)
			let underlineCharWidth = "_".width(usingFont: UIFont.monospacedSystemFont(ofSize: 14, weight: .regular))
			
			let underlineCount = max(3, Int(availableWidth / underlineCharWidth))
			let underlineString = String(repeating: "_", count: underlineCount)
			
			HStack() {
				Text(title)
					.font(.abeezeeRegular(size: Sizes.Text.small))
					.foregroundStyle(Color.semanticColorText)
					.fixedSize()
					.frame(width: titleWidth, alignment: .leading)
				
				Text(underlineString)
					.font(.system(size: Sizes.Text.small, design: .monospaced))
					.foregroundStyle(Color.semanticColorText)
					.fixedSize()
					.frame(width: availableWidth, alignment: .center)
				
				
				Text(value)
					.font(.abeezeeRegular(size: Sizes.Text.small))
					.fixedSize()
					.frame(width: valueWidth, alignment: .trailing)
				
			}
			.frame(width: geometry.size.width, alignment: .leading)
		}
		.frame(height: Sizes.Height.priceRow)
	}
}


private extension String {
	func width(usingFont font: UIFont) -> CGFloat {
		let attributes = [NSAttributedString.Key.font: font]
		let size = (self as NSString).size(withAttributes: attributes)
		return size.width
	}
}

