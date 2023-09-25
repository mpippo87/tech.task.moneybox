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
}

final class AccountViewModel: AccountViewModelProtocol {

    // MARK: - Parameters

    private weak var coordinator: AccountCoordinator?
    private let account: Account

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

    // MARK: - Init

    init(
        coordinator: AccountCoordinator? = nil,
        account: Account
    ) {
        self.coordinator = coordinator
        self.account = account
    }

    // MARK: - Methods

}
