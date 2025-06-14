//
//  ErrorView.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

struct ErrorView: View {
	
	let onRetry: () -> Void
	
    var body: some View {
		VStack(spacing: Sizes.Padding.small) {
			Image(ConstantStrings.ConstantImages.errorIllustration)
				.customImageStyle()
			VStack(spacing: Sizes.Padding.large) {
				titleView
				buttonView
			}
		}
    }
}

private extension ErrorView {
	
	
	var titleView: some View {
		VStack(spacing: Sizes.Padding.tiny) {
			Text(ConstantStrings.Error.title)
					.font(.abeezeeRegular(size: Sizes.Text.double).bold())
			Text(ConstantStrings.Error.subtitle)
					.opacity(Sizes.Opacity.secondaryText)
					.font(.abeezeeRegular(size: Sizes.Text.double))
			}
		}
	
	var buttonView: some View {
		Button(action: {
			onRetry()
		}) {
			HStack(spacing: Sizes.Padding.small) {
				Image("refreshIcon")
				Text(ConstantStrings.Error.refresh)
			}
			.foregroundColor(.white)
			.padding(.horizontal, Sizes.Padding.large)
			.padding(.vertical, Sizes.Padding.medium)
			.background(Color.purpleMain)
			.cornerRadius(Sizes.Radius.buttonCornerRadius)
		}
	}
}


extension Image {
	func customImageStyle() -> some View {
		self
			.resizable()
			.aspectRatio(contentMode: .fill)
			.clipped()
			.frame(width: Sizes.Width.imageError, height: Sizes.Width.imageError)
	}
}

#Preview {
	ErrorView(onRetry: {})
}
