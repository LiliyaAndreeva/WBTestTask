//
//  MockNetworkService.swift
//  WBTestTaskTests
//
//  Created by Лилия Андреева on 14.06.2025.
//

import Foundation
@testable import WBTestTask

final class NetworkServiceMock: NetworkServiceProtocol {
	var didCallFetch = false
	var mockResponse: Any?
	var shouldThrow = false

	func fetch<T>(_ type: T.Type, from url: URL) async throws -> T where T: Decodable {
		didCallFetch = true
		if shouldThrow {
			throw URLError(.notConnectedToInternet)
		}
		return mockResponse as! T
	}
}
