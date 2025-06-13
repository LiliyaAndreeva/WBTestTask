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
			Image("illustrationFlashlightGuide")
				.customImageStyle()
			Text("Ничего не найдено")
		}
    }
}

#Preview {
    EmptyView()
}
