//
//  ConstantStrings.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 14.06.2025.
//

import Foundation

enum ConstantStrings {

	// MARK: - ErrorView
	enum Error {
		static let title = "Что-то пошло не так"
		static let subtitle = "Попробуйте позднее"
		static let refresh = "Обновить"
	}

	// MARK: - EmptyView
	enum Empty {
		static let message = "Ничего не найдено"
	}

	// MARK: - Navigation
	enum Navigation {
		static let title = "Цены и скидки"
	}

	// MARK: - Product Info
	enum Product {
		static let skuPrefix = "Арт."
		static let wbSkuPrefix = "Арт. WB"
	}

	// MARK: - Price Info
	enum Price {
		static let original = "Цена продавца до скидки"
		static let discount = "Скидка продавца"
		static let discounted = "Цена со скидкой"
	}

	// MARK: - Filters
	enum Filter {
		static let pickerTitle = "Фильтр"
		static let all = "Все товары"
		static let withoutPrice = "Товары без цены"
	}
	
	enum ConstantImages {
		static let errorIllustration = "illustrationCircleError"
		static let emptyIllustration = "illustrationFlashlightGuide"
		static let loadingIndicator = "loadingIndicator"
		static let elipsisIcon = "ellipsis"
	}
	
	enum ActionSheet {
		static let copySKU = "Скопировать артикул"
		static let copyWBSKU = "Скопировать артикул WB"
		static let cancel = "Cancel"
	}
}
