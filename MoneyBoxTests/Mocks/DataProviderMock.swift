//
//  DataProviderMock.swift
//  MoneyBoxTests
//
//  Created by Filippo Minelle on 26/09/2023.
//

import Foundation
@testable import MoneyBox
import Networking

final class DataProviderMock: DataProviderLogic {

    // MARK: - Properties

    private let fileName: String

    // MARK: - Init

    init(fileName: String = "") {
        self.fileName = fileName
    }

    // MARK: - DataProviderLogic

    func login(request: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        StubData.read(file: fileName, callback: completion)
    }

    func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        StubData.read(file: fileName, callback: completion)
    }

    func addMoney(request: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        StubData.read(file: fileName, callback: completion)
    }
}
