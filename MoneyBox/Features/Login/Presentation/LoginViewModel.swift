//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation
import Networking

protocol LoginViewModelProtocol {}

final class LoginViewModel {

    // MARK: - Parameters

    private weak var coordinator: LoginCoordinator?
    private let loginUseCase: LoginUseCase

    // MARK: - Init

    init(
        coordinator: LoginCoordinator? = nil,
        usecase: LoginUseCase = LoginUseCase(authService: AuthService(authDataSource: DataProvider()))
    ) {
        self.coordinator = coordinator
        loginUseCase = usecase
    }

    // MARK: - Methods

    func login(email: String, password: String) {
        Task {
            if let user = try? await loginUseCase.login(email: email, password: password) {
                await coordinator?.goToAccounts(user)
            }
        }
    }
}
