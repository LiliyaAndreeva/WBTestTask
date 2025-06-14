//
//  Sizes.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 14.06.2025.
//

import Foundation

enum Sizes {
	
	// MARK: - Button Sizes
	
	static let optionsButtonSize: CGFloat = 32
	
	// MARK: - Widths
	enum Width {
		static let image: CGFloat = 84
		static let categoryLabel: CGFloat = 81
		static let imageError: CGFloat = 240
	}
	
	// MARK: - Heights
	enum Height {
		static let categoryLabel: CGFloat = 24
		static let image: CGFloat = 116
		static let priceRow: CGFloat = 20
		static let imageError: CGFloat = 240
	}

	// MARK: - Corner Radius
	enum Radius {
		static let badgeCornerRadius: CGFloat = 6
		static let buttonCornerRadius: CGFloat = 12
		static let cornerRadius: CGFloat = 16
	}
	
	// MARK: - Padding
	
	enum Padding {
		static let micro: CGFloat = 2
		static let tiny: CGFloat = 4
		static let small: CGFloat = 8       // используется для spacing в VStacks
		static let medium: CGFloat = 12     // horizontal padding
		static let normal: CGFloat = 16     // горизонтальные + вертикальные отступы
		static let vertical: CGFloat = 18   // top/bottom
		static let large: CGFloat = 24
		static let xLarge: CGFloat = 32     // для priceList нижний padding
	}
	
	// MARK: - Text Sizes
	
	enum Text {
		static let small: CGFloat = 14
		static let normal: CGFloat = 16
		static let double: CGFloat = 18
	}
	
	// MARK: - Opacity
	
	enum Opacity {
		static let secondaryText: Double = 0.6
		static let disabled: Double = 0.4
		static let faint: Double = 0.2
	}
}
