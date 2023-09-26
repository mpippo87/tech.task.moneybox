//
//  AccountUseCase.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 26/09/2023.
//

import Foundation
import Networking

protocol AccountUseCaseProtocol {
    func execute(amount: Int, investorProductID: Int) async -> Double?
}

final class AccountUseCase: AccountUseCaseProtocol {

    // MARK: - Properties

    private let accountRepository: AccountRepositoryProtocol

    // MARK: - Init

    init(accountRepository: AccountRepositoryProtocol = AccountRepository()) {
        self.accountRepository = accountRepository
    }

    // MARK: - Methods

    func execute(amount: Int, investorProductID: Int) async -> Double? {
        guard let moneybox = try? await accountRepository.addMoney(amount: amount, investorProductID: investorProductID).moneybox else {
            return nil
        }
        return moneybox
    }
}
