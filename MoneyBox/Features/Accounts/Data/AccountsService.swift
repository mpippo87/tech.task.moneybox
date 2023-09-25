//
//  AccountsService.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 25/09/2023.
//

import Foundation
import Networking

protocol AccountsServiceProtocol {
    func fetchAccounts() async throws -> AccountResponse
}

final class AccountsService: AccountsServiceProtocol {

    // MARK: - Properties

    private let dataProviderLogic: DataProviderLogic

    // MARK: - Init

    init(dataProviderLogic: DataProviderLogic) {
        self.dataProviderLogic = dataProviderLogic
    }

    // MARK: - Fetch Accounts

    func fetchAccounts() async throws -> AccountResponse {
        try await withCheckedThrowingContinuation { continuation in
            dataProviderLogic.fetchProducts(completion: { result in
                switch result {
                case .success(let response):
                    print("§ Fetch Accounts successful: \(response)")
                    continuation.resume(returning: response)
                case .failure(let error):
                    print("§ Fetch Accounts error: \(error)")
                    continuation.resume(throwing: error)
                }
            })
        }
    }
}
