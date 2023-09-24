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

    weak var viewModel: LoginViewModel?

    // MARK: - Init

    init(viewModel: LoginViewModel?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the main view
        let mainView = UIView()
        mainView.backgroundColor = .color2
        view = mainView

        // Add UI elements to the main view
        mainView.addSubview(logoImage)
        mainView.addSubview(usernameTextField)
        mainView.addSubview(passwordTextField)
        mainView.addSubview(loginButton)

        // Define constraints
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.l),
            logoImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 50),

            usernameTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: Padding.l),
            usernameTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Padding.m),
            usernameTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Padding.m),

            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: Padding.s),
            passwordTextField.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Padding.m),
            passwordTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Padding.m),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Padding.m),
            loginButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Padding.m),
            loginButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Padding.m)
        ])
    }

    @objc func loginButtonTapped() {
        if let username = usernameTextField.text,
           let password = passwordTextField.text {
            viewModel?.login(username: username, password: password)

            if viewModel?.login(username: username, password: password) == true {
                let accountsViewController = AccountsViewController()
                navigationController?.pushViewController(accountsViewController, animated: true)
            } else {
                // Handle login failure (e.g., show an alert)
            }
        }
    }
}
