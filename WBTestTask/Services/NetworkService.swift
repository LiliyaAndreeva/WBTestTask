//
//  NetworkService.swift
//  WBTestTask
//
//  Created by Лилия Андреева on 12.06.2025.
//

import Foundation
protocol NetworkServiceProtocol {
	func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
	func fetch<T>(_ type: T.Type, from url: URL) async throws -> T where T : Decodable {
		let (data, _) = try await URLSession.shared.data(from: url)
		return try JSONDecoder().decode(T.self, from: data)
	}
}
