//
//  Keychain.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 25/09/2023.
//

extension String {

    var isValidEmail: Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        guard let regex = try? NSRegularExpression(pattern: emailRegex, options: []) else {
            return false
        }
        let range = NSRange(location: 0, length: utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
