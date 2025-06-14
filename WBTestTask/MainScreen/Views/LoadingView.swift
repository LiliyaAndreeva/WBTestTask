//
//  LoadingView.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

struct LoadingView: View {
	@State private var isAnimating = false
	
	var body: some View {
		Image("loadingIndicator")
			.rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
			.animation(
				Animation.linear(duration: 1)
					.repeatForever(autoreverses: false),
				value: isAnimating
			)
			.onAppear {
				isAnimating = true
			}
	}
}

#Preview {
    LoadingView()
}

