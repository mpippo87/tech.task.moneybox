//
//  AccountUseCase.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 26/09/2023.
//

import Foundation
import Networking

protocol AccountUseCaseProtocol {
    func addTenPounds(amount: Int, investorProductID: Int) async -> Double?
}

final class AccountUseCase {

    // MARK: - Properties

    private let accountService: AccountServiceProtocol

    // MARK: - Init

    init(accountsService: AccountServiceProtocol) {
        accountService = accountsService
    }

    // MARK: - Fetch Accounts

    func addTenPounds(amount: Int, investorProductID: Int) async -> Double? {
        try? await accountService.addMoney(amount: amount, investorProductID: investorProductID).moneybox
    }
}
