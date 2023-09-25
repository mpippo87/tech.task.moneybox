//
//  AccountsViewModel.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation
import Networking

protocol AccountsViewModelProtocol {}

final class AccountsViewModel: AccountsViewModelProtocol {

    // MARK: - Parameters

    private weak var coordinator: AccountsCoordinator?
    private let loginUseCase: LoginUseCase

    // MARK: - Init

    init(
        coordinator: AccountsCoordinator? = nil,
        usecase: LoginUseCase = LoginUseCase(authService: AuthService(authDataSource: DataProvider()))
    ) {
        self.coordinator = coordinator
        loginUseCase = usecase
    }

    // MARK: - Methods

}
