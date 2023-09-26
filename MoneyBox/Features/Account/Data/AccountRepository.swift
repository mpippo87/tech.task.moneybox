//
//  AccountRepository.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 26/09/2023.
//

import Foundation
import Networking

protocol AccountRepositoryProtocol {
    func addMoney(amount: Int, investorProductID: Int) async throws -> OneOffPaymentResponse
}

final class AccountRepository: AccountRepositoryProtocol {

    // MARK: - Properties

    private let dataProvider: DataProviderLogic

    // MARK: - Init

    init(dataProvider: DataProviderLogic = DataProvider()) {
        self.dataProvider = dataProvider
    }

    // MARK: - Fetch Accounts

    func addMoney(amount: Int, investorProductID: Int) async throws -> OneOffPaymentResponse {
        try await withCheckedThrowingContinuation { continuation in
            dataProvider.addMoney(request: OneOffPaymentRequest(amount: amount, investorProductID: investorProductID), completion: { result in
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