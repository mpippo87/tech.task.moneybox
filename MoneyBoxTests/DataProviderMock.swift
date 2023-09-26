//
//  DataProviderMock.swift
//  MoneyBoxTests
//
//  Created by Filippo Minelle on 26/09/2023.
//

import Foundation
@testable import MoneyBox
import Networking

final class DataProviderMock: DataProviderLogic {

    // MARK: - Properties

    private let fileName: String

    // MARK: - Init

    init(fileName: String = "") {
        self.fileName = fileName
    }

    // MARK: - DataProviderLogic

    func login(request: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        StubData.read(file: fileName, callback: completion)
    }

    // Implement the remaining methods with stubbed data if needed
    func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        StubData.read(file: fileName, callback: completion)
    }

    func addMoney(request: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        StubData.read(file: fileName, callback: completion)
    }
}

class DataProviderMockFailure: DataProviderLogic {
    func login(request: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        // Simulate a login failure with an error response
        let error = NSError(domain: "MockErrorDomain", code: 123, userInfo: nil)
        completion(.failure(error))
    }

    func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        // Implement with stubbed data if needed
    }

    func addMoney(request: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        // Implement with stubbed data if needed
    }
}

class DataProviderMockInvalidResponse: DataProviderLogic {
    func login(request: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        // Simulate an invalid JSON response
        let invalidJSON = "{ invalid }".data(using: .utf8)!
        let result = Result<LoginResponse, Error>.init(catching: {
            try JSONDecoder().decode(LoginResponse.self, from: invalidJSON)
        })
        completion(result)
    }

    func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        // Implement with stubbed data if needed
    }

    func addMoney(request: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        // Implement with stubbed data if needed
    }
}
