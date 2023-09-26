//
//  LoginUseCase.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Networking

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) async throws -> User?
}

final class LoginUseCase: LoginUseCaseProtocol {

    // MARK: - Properties

    private let loginRepository: LoginRepositoryProtocol

    // MARK: - Init

    init(authService: LoginRepositoryProtocol) {
        loginRepository = authService
    }

    // MARK: - Methods

    func execute(email: String, password: String) async throws -> User? {
        do {
            let user = try await loginRepository.authenticate(with: email, password: password).user
            guard let name = user.firstName, let surname = user.lastName else {
                return nil
            }
            return User(name: name, surname: surname)
        } catch {
            throw error
        }
    }
}
