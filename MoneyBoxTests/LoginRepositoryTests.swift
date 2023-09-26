//
//  LoginRepositoryTests.swift
//  MoneyBoxTests
//
//  Created by Filippo Minelle on 26/09/2023.
//

@testable import MoneyBox
import Networking
import XCTest

final class LoginRepositoryTests: XCTestCase {

    // MARK: - Properties

    var loginRepository: LoginRepository?

    // MARK: - XCTestCase

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {
        loginRepository = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests

    func test_authenticate_whenLoginSucceed_theTokenShouldMatch() async {
        loginRepository = LoginRepository(dataProvider: DataProviderMock(fileName: "LoginSucceed"))
        let email = "test+ios@moneyboxapp.com"
        let password = ""

        do {
            let loginResponse = try await loginRepository?.authenticate(with: email, password: password)
            XCTAssertNotNil(loginResponse)
            XCTAssertEqual(Authentication.token, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
        } catch {
            XCTFail("test_authenticate_whenLoginSucceed_theTokenShouldMatch failed with error: \(error)")
        }
    }

    func test_authenticate_whenLoginFail_theTokenShouldBeNil() async {
        loginRepository = LoginRepository(dataProvider: DataProviderMock(fileName: "LoginFailed"))
        let email = "test+ios@moneyboxapp.com"
        let password = ""

        do {
            let _ = try await loginRepository?.authenticate(with: email, password: password)
            XCTAssertNil(Authentication.token)
            XCTFail("test_authenticate_whenLoginFail_theTokenShouldBeNil should fail")
        } catch {
            XCTAssertEqual(error.localizedDescription, "stub decoding error")
        }
    }
}
