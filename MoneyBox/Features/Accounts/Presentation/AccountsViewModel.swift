//
//  AccountsViewModel.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation
import Networking

protocol AccountsViewModelProtocol {
    var totalValue: Double { get }
    var nameLabelText: String { get }
    var totalPlanValueLabelText: String { get }
    var userAccountsData: [Account] { get }

    func fetchAccounts() async
    func didSelectAccount(at indexPath: IndexPath)
}

final class AccountsViewModel: AccountsViewModelProtocol {

    // MARK: - Properties

    private weak var coordinator: AccountsCoordinator?
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
        "Total Plan Value: £\(totalValue)"
    }

    var userAccountsData: [Account] {
        accounts
    }

    // MARK: - Init

    init(
        coordinator: AccountsCoordinator? = nil,
        accountsUseCase: AccountsUseCase = AccountsUseCase(accountsService: AccountsService(dataProviderLogic: DataProvider())),
        user: User
    ) {
        self.coordinator = coordinator
        self.user = user
        self.accountsUseCase = accountsUseCase
    }

    // MARK: - Methods

    func fetchAccounts() async {
        accounts = await accountsUseCase.fetchAccounts()
    }

    func didSelectAccount(at indexPath: IndexPath) {
        let selectedAccount = accounts[indexPath.row]
        print("§ Selected account: \(selectedAccount)")
    }
}
