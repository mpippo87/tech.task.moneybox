//
//  LoginUseCase.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Networking

protocol LoginUseCaseProtocol {
    func login(email: String, password: String) async throws -> User?
}

final class LoginUseCase: LoginUseCaseProtocol {

    // MARK: - Properties

    private let authService: AuthServiceProtocol

    // MARK: - Init

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    // MARK: - AuthStore

    func login(email: String, password: String) async throws -> User? {
        guard let user = try? await authService.authenticate(with: email, password: password).user,
              let name = user.firstName, let surname = user.lastName else {
            return nil
        }
        return User(name: name, surname: surname)
    }
}

import Foundation

class AuthDataSource {
    private let keychainManager: KeychainManager

    init(service: String) {
        keychainManager = KeychainManager(service: service)
    }

    // MARK: - Public Methods

    func saveAuthToken(_ token: String, forKey key: String) -> Bool {
        let dataToSave = token.data(using: .utf8)!
        return keychainManager.save(data: dataToSave, forKey: key)
    }

    func loadAuthToken(forKey key: String) -> String? {
        if let loadedData = keychainManager.load(forKey: key),
           let loadedString = String(data: loadedData, encoding: .utf8) {
            return loadedString
        }
        return nil
    }

    func deleteAuthToken(forKey key: String) -> Bool {
        keychainManager.delete(forKey: key)
    }
}
