@testable import MBFoundation
import XCTest

final class StringEmailValidationTests: XCTestCase {

    // MARK: - Tests

    func test_isValidEmail_validEmail_expectTrue() {
        let testingEmails = ["user@example.com", "name.surname@domain.co.uk", "user1234@subdomain.domain.com"]
        for email in testingEmails {
            XCTAssertTrue(email.isValidEmail)
        }
    }

    func test_isValidEmail_withoutAtSymbol_shouldReturnFalse() {
        let testingEmails = ["userexample.com", "name.surname", "user@domain"]
        for email in testingEmails {
            XCTAssertFalse(email.isValidEmail)
        }
    }

    func test_isValidEmail_withoutDomain_shouldReturnFalse() {
        let testingEmails = [
            "user@",
            "name.surname@",
            "user1234@"
        ]
        for email in testingEmails {
            XCTAssertFalse(email.isValidEmail)
        }
    }

    func test_isValidEmail_withInvalidCharacters_shouldReturnFalse() {
        let testingEmails = [
            "user#example.com",
            "name!surname@domain.co.uk",
            "user$1234@domain.com"
        ]
        for email in testingEmails {
            XCTAssertFalse(email.isValidEmail)
        }
    }

    func test_isValidEmail_withoutTopLevelDomain_shouldReturnFalse() {
        let testingEmails = [
            "user@example",
            "name.surname@domain.",
            "user1234@subdomain.domain."
        ]
        for email in testingEmails {
            XCTAssertFalse(email.isValidEmail)
        }
    }

    func test_isValidEmail_tooShort_shouldReturnFalse() {
        let testingEmails = [
            "a@b.c",
            "user@domain.",
            "a@b."
        ]
        for email in testingEmails {
            XCTAssertFalse(email.isValidEmail)
        }
    }
}
