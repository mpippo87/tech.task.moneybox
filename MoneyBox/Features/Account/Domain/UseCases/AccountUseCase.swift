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

    private let accountRepository: AccountRepositoryProtocol

    // MARK: - Init

    init(accountRepository: AccountRepositoryProtocol = AccountRepository()) {
        self.accountRepository = accountRepository
    }

    // MARK: - Methods

    func execute(amount: Int, investorProductID: Int) async -> Double? {
        try? await accountRepository.addMoney(amount: amount, investorProductID: investorProductID).moneybox
    }
}
