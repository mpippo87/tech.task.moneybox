//
//  AccountsRepository.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 25/09/2023.
//

import Foundation
import Networking

protocol AccountsRepositoryProtocol {
    func fetchAccounts() async throws -> AccountResponse
}

final class AccountsRepository: AccountsRepositoryProtocol {

    // MARK: - Properties

    private let dataProvider: DataProviderLogic

    // MARK: - Init

    init(dataProvider: DataProviderLogic = DataProvider()) {
        self.dataProvider = dataProvider
    }

    // MARK: - Fetch Accounts

    func fetchAccounts() async throws -> AccountResponse {
        try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.dataProvider.fetchProducts(completion: { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }
}
