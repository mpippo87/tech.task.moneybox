//
//  AuthService.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation
import Networking

protocol AuthServiceProtocol {
    func authenticate(with email: String, password: String) async throws -> LoginResponse
}

final class AuthService: AuthServiceProtocol {

    // MARK: - Properties

    private let dataProviderLogic: DataProviderLogic
    private let sessionManager: SessionManager

    // MARK: - Init

    init(
        authDataSource: DataProviderLogic,
        sessionManager: SessionManager = SessionManager()
    ) {
        dataProviderLogic = authDataSource
        self.sessionManager = sessionManager
    }

    // MARK: - AuthServiceProtocol

    func authenticate(with email: String, password: String) async throws -> LoginResponse {
        try await withCheckedThrowingContinuation { continuation in
            dataProviderLogic.login(request: LoginRequest(email: email, password: password)) { [weak self] result in
                switch result {
                case .success(let response):
                    print("§ Login successful: \(response)")
                    self?.sessionManager.setUserToken(response.session.bearerToken)
                    continuation.resume(returning: response)
                case .failure(let error):
                    print("§ Login error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
