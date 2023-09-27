//
//  LoginStorage.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 26/09/2023.
//

import MBFoundation

final class LoginStorage {

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
