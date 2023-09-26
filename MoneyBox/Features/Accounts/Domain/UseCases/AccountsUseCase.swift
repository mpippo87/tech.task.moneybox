//
//  AccountsUseCase.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 25/09/2023.
//

import Foundation
import Networking

protocol AccountsUseCaseProtocol {
    func fetchAccounts() async -> [Account]
}

final class AccountsUseCase {

    // MARK: - Properties

    private let accountsService: AccountsServiceProtocol

    // MARK: - Init

    init(accountsService: AccountsServiceProtocol) {
        self.accountsService = accountsService
    }

    // MARK: - Fetch Accounts

    func fetchAccounts() async -> [Account] {
        guard let products = try? await accountsService.fetchAccounts().productResponses else {
            return []
        }
        return products.compactMap { product in
            guard let id = product.id else { return nil }
            return Account(
                id: id,
                title: product.assetBox?.title ?? "",
                planValue: product.planValue ?? 0.0,
                moneybox: product.moneybox ?? 0.0
            )
        }
    }
}
