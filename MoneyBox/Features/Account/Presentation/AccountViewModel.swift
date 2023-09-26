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

    func addTenPounds() async
}

final class AccountViewModel: AccountViewModelProtocol {

    // MARK: - Parameters

    private weak var coordinator: AccountCoordinator?
    private let accountService: AccountRepositoryProtocol
    private var account: Account

    // MARK: - Computed Properties

    var accountTitle: String {
        account.title
    }

    var planValue: String {
        String(account.planValue)
    }

    var moneybox: String {
        String(account.moneybox)
    }

    @Published var moneyboxValue: Double? = nil

    // MARK: - Init

    init(
        coordinator: AccountCoordinator? = nil,
        accountService: AccountRepositoryProtocol,
        account: Account
    ) {
        self.coordinator = coordinator
        self.accountService = accountService
        self.account = account
    }

    // MARK: - Methods

    func addTenPounds() async {
        if let moneybox = try? await accountService.addMoney(amount: 10, investorProductID: account.id).moneybox {
            print("§ 1 account.moneybox: \(account.moneybox)")
            // account.moneybox = moneybox
            print("§ 2 account.moneybox: \(moneybox)")
        }
    }
}
