//
//  AccountViewModel.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation
import Networking

protocol AccountViewModelProtocol {
    var accountTitle: String { get }
    var planValue: String { get }
    var moneybox: String { get }

    func addTenPounds(_ completion: @escaping (Double?) -> Void)
}

final class AccountViewModel: AccountViewModelProtocol {

    // MARK: - Parameters

    private weak var coordinator: AccountCoordinator?
    private let accountUseCase: AccountUseCaseProtocol
    private var account: Account

    // MARK: - Computed Properties

    var accountTitle: String {
        account.title
    }

    var planValue: String {
        "Plan Value: £\(account.planValue)"
    }

    var moneybox: String {
        "Moneybox: £\(account.moneybox)"
    }

    @Published var moneyboxValue: Double? = nil

    // MARK: - Init

    init(
        coordinator: AccountCoordinator? = nil,
        accountUseCase: AccountUseCaseProtocol = AccountUseCase(accountRepository: AccountRepository()),
        account: Account
    ) {
        self.coordinator = coordinator
        self.accountUseCase = accountUseCase
        self.account = account
    }

    // MARK: - Methods

    func addTenPounds(_ completion: @escaping (Double?) -> Void) {
        Task {
            if let moneybox = await accountUseCase.execute(amount: 10, investorProductID: account.id) {
                completion(moneybox)
            } else {
                completion(nil)
            }
        }
    }
}
