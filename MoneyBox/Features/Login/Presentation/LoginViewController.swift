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
        image.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return image
    }()

    private let usernameTextField: TextField = .init(placeholder: "Email", style: .email)

    private let passwordTextField: TextField = .init(placeholder: "Password", style: .password)

    private let loginButton: Button = .init(title: "Login",
                                            style: .primary,
                                            target: self,
                                            action: #selector(loginButtonTapped))

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
        view.backgroundColor = .color2
        view.addSubview(logoImage)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)

        // Define constraints
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Padding.xl),
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),
            logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.m),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 50),

            usernameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: Padding.l),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.m),

            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: Padding.s),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.m),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Padding.m),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.m)
        ])
    }

    // TODO: To remove
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = "test+ios2@moneyboxapp.com"
        passwordTextField.text = "P455word12"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginButtonTapped()
    }

    // MARK: - Actions

    @objc func loginButtonTapped() {
        if let email = usernameTextField.text,
           let password = passwordTextField.text {
            viewModel?.login(email: email, password: password)
        }
    }
}
