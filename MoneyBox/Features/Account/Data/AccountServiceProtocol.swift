//
//  AccountServiceProtocol.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 26/09/2023.
//

import Foundation
import Networking

protocol AccountServiceProtocol {
    func addMoney(amount: Int, investorProductID: Int) async throws -> OneOffPaymentResponse
}

final class AccountService: AccountServiceProtocol {

    // MARK: - Properties

    private let dataProviderLogic: DataProviderLogic

    // MARK: - Init

    init(dataProviderLogic: DataProviderLogic) {
        self.dataProviderLogic = dataProviderLogic
    }

    // MARK: - Fetch Accounts

    func addMoney(amount: Int, investorProductID: Int) async throws -> OneOffPaymentResponse {
        try await withCheckedThrowingContinuation { continuation in
            dataProviderLogic.addMoney(request: OneOffPaymentRequest(amount: amount, investorProductID: investorProductID), completion: { result in
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
