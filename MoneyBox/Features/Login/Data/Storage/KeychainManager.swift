//
//  Keychain.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 25/09/2023.
//

import Foundation
import Security

final class KeychainManager {

    // MARK: - Properties

    private let service: String

    // MARK: - Init

    init(service: String) {
        self.service = service
    }

    // MARK: - Public Methods

    func save(data: Data, forKey key: String) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as [CFString: Any]

        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)

        return status == errSecSuccess
    }

    func load(forKey key: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [CFString: Any]

        var data: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &data)

        if status == errSecSuccess {
            return data as? Data
        }

        return nil
    }

    func delete(forKey key: String) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key
        ] as [CFString: Any]

        let status = SecItemDelete(query as CFDictionary)

        return status == errSecSuccess
    }
}
