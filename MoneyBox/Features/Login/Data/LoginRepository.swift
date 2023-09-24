//
//  LoginRepository.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import Foundation
import Networking

final class LoginRepository {
    
    // MARK: - Properties
    
    private let api: API.Login
    
    // MARK: - Init
    
    init(api: API.Login) {
        self.api = api
    }
    
}
