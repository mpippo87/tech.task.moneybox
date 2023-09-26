//
//  AccountsViewModel.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation
import Networking

protocol AccountsViewModelProtocol {
    var nameLabelText: String { get }
    var totalValue: Double { get }
    var totalPlanValueLabelText: String { get }
    var userAccountsData: [Account] { get }

    func fetchAccounts() async
    func didSelectAccount(at indexPath: IndexPath)
}

final class AccountsViewModel: AccountsViewModelProtocol {

    // MARK: - Properties

    private var coordinator: AccountsCoordinator?
    private let accountsUseCase: AccountsUseCase
    private let user: User
    private var accounts: [Account] = []

    // MARK: - Computed Properties

    var nameLabelText: String {
        "Hello \(user.name)!"
    }

    var totalValue: Double {
        accounts.reduce(0) { $0 + $1.planValue }
    }

    var totalPlanValueLabelText: String {
        "Total Plan Value: \(String(format: "£%.2f", totalValue))"
    }

    var userAccountsData: [Account] {
        accounts
    }

    // MARK: - Init

    init(
        coordinator: AccountsCoordinator? = nil,
        accountsUseCase: AccountsUseCase = AccountsUseCase(accountsRepository: AccountsRepository()),
        user: User
    ) {
        self.coordinator = coordinator
        self.accountsUseCase = accountsUseCase
        self.user = user
    }

    // MARK: - Methods

    func fetchAccounts() async {
        accounts = await accountsUseCase.execute()
    }

    func didSelectAccount(at indexPath: IndexPath) {
        let selectedAccount = accounts[indexPath.row]
        coordinator?.goToAccount(selectedAccount)
    }
}
