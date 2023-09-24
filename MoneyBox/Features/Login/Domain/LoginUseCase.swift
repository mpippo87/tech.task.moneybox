//
//  LoginUseCase.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation

protocol LoginUseCaseProtocol {

    // typealias Result = Result<Bool, Error> // You can define a custom result type

    func login(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class LoginUseCase: LoginUseCaseProtocol {

    // You can inject any necessary dependencies here, such as a network service or repository

    func login(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Here, you would typically make a network request or interact with a repository
        // to perform the login operation.

        // Example:
        // Authenticate the user using a service or API call.
        // Handle success and failure cases and provide the result in the completion handler.

        // For the sake of the example, let's assume a successful login here.
        let isAuthenticated = true
        if isAuthenticated {
            completion(.success(true))
        } else {
            // If login fails, provide an error.
            let error = NSError(domain: "LoginErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Login failed."])
            completion(.failure(error))
        }
    }
}
