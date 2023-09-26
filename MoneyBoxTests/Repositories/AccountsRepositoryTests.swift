//
//  AccountsRepositoryTests.swift
//  MoneyBoxTests
//
//  Created by Filippo Minelle on 26/09/2023.
//

@testable import MoneyBox
import Networking
import XCTest

final class AccountsRepositoryTests: XCTestCase {

    // MARK: - Properties

    var accountsRepository: AccountsRepository?

    // MARK: - XCTestCase

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {
        accountsRepository = nil
        try super.tearDownWithError()
    }

    // MARK: - Tests

    func test_fetchAccounts_whenSuccess_shouldReturnValidData() async {
        accountsRepository = AccountsRepository(dataProvider: DataProviderMock(fileName: "Accounts"))

        do {
            let accountResponse = try await accountsRepository?.fetchAccounts()
            XCTAssertEqual(accountResponse?.totalPlanValue, 15707.080000)
            XCTAssertEqual(accountResponse?.totalEarnings, 2353.480000)
            XCTAssertEqual(accountResponse?.totalContributionsNet, 13355.42)
            XCTAssertEqual(accountResponse?.totalEarningsAsPercentage, 17.62)
            XCTAssertEqual(accountResponse?.productResponses?.first?.planValue, 10526.09)
            XCTAssertEqual(accountResponse?.productResponses?.first?.moneybox, 570.00)
            XCTAssertEqual(accountResponse?.accounts?.first?.type, "Isa")
            XCTAssertEqual(accountResponse?.accounts?.first?.name, "Stocks & Shares ISA")
        } catch {
            XCTFail("test_fetchAccounts_whenSuccess_shouldReturnValidData should not fail")
        }
    }
}
