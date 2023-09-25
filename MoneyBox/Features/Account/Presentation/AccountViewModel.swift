//
//  AccountViewModel.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation
import Networking

protocol AccountViewModelProtocol {}

final class AccountViewModel: AccountViewModelProtocol {

    // MARK: - Parameters

    private weak var coordinator: AccountCoordinator?
    private let loginUseCase: LoginUseCase

    // MARK: - Init

    init(
        coordinator: AccountCoordinator? = nil,
        usecase: LoginUseCase = LoginUseCase(authService: AuthService(authDataSource: DataProvider()))
    ) {
        self.coordinator = coordinator
        loginUseCase = usecase
    }

    // MARK: - Methods

//    func login(email: String, password: String) {
//        Task {
//            if await loginUseCase.login(email: email, password: password) {
//                await coordinator?.goToAccounts()
//            }
//        }
//    }
}
