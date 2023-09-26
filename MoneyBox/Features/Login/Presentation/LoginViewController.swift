//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import MBUI
import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Properties

    private let logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "moneybox"))
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let usernameTextField: TextField = .init(placeholder: "Email", style: .email)
    private let passwordTextField: TextField = .init(placeholder: "Password", style: .password)
    private let loginButton: Button = .init(title: "Login",
                                            style: .primary,
                                            target: self,
                                            action: #selector(loginButtonTapped))

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    private lazy var stackView: UIStackView = {
        let textFieldsStackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = Padding.m

        let stackView = UIStackView(arrangedSubviews: [textFieldsStackView, errorLabel, loginButton])
        stackView.axis = .vertical
        stackView.spacing = Padding.xl
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    var viewModel: LoginViewModel?

    // MARK: - Init

    init(viewModel: LoginViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        navigationItem.titleView = logoImage
        view.backgroundColor = .color2
        view.addSubview(stackView)

        // Constraints
        logoImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.xl),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.m)
        ])
    }

    // MARK: - Actions

    @objc func loginButtonTapped() {
        guard let email = usernameTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            updateError("Email and password cannot be empty")
            return
        }

        do {
            try viewModel?.login(email: email, password: password)
            updateError(nil)
        } catch {
            updateError("Invalid Email and password")
        }
    }

    private func updateError(_ message: String?) {
        errorLabel.text = message
        errorLabel.isHidden = message == nil
    }
}
