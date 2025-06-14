//
//  EmptyView.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
		VStack {
			Image(ConstantStrings.ConstantImages.emptyIllustration)
				.customImageStyle()
			Text(ConstantStrings.Empty.message)
				.font(.sfRegular(size: Sizes.Text.double))
		}
    }
}

#Preview {
    EmptyView()
}
