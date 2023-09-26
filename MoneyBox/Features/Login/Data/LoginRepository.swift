//
//  LoginRepository.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation
import Networking

protocol LoginRepositoryProtocol {
    func authenticate(with email: String, password: String) async throws -> LoginResponse
}

final class LoginRepository: LoginRepositoryProtocol {

    // MARK: - Properties

    private let dataProvider: DataProviderLogic
    private let sessionManager: SessionManager

    // MARK: - Init

    init(
        dataProvider: DataProviderLogic = DataProvider(),
        sessionManager: SessionManager = SessionManager()
    ) {
        self.dataProvider = dataProvider
        self.sessionManager = sessionManager
    }

    // MARK: - LoginRepositoryProtocol

    func authenticate(with email: String, password: String) async throws -> LoginResponse {
        try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.dataProvider.login(request: LoginRequest(email: email, password: password)) { result in
                switch result {
                case .success(let response):
                    self?.sessionManager.setUserToken(response.session.bearerToken)
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

final class AuthDataSource {

    // MARK: - Properties

    private let keychainManager: KeychainManager

    // MARK: - Init

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
