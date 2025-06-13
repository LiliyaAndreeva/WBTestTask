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
		VStack(spacing: 8) {
			Image("illustrationCircleError")
				.customImageStyle()
			VStack(spacing: 24) {
				titleView
				buttonView
			}
		}
    }
}

private extension ErrorView {
	
	
	var titleView: some View {
			VStack(spacing: 4) {
				Text("Что-то пошло не так")
					.font(.customRegular(size: 18).bold())
				Text("Попробуйте позднее")
					.opacity(0.6)
					.font(.customRegular(size: 18))
			}
		}
	
	var buttonView: some View {
		Button(action: {
			onRetry()
		}) {
			HStack(spacing: 8) {
				Image("refreshIcon")
				Text("Обновить")
			}
			.foregroundColor(.white)
			.padding(.horizontal, 24)
			.padding(.vertical, 12)
			.background(Color.purpleMain)
			.cornerRadius(12)
		}
	}
}


extension Image {
	func customImageStyle() -> some View {
		self
			.resizable()
			.aspectRatio(contentMode: .fill)
			.clipped()
			.frame(width: 240, height: 240)
	}
}

#Preview {
	ErrorView(onRetry: {})
}
