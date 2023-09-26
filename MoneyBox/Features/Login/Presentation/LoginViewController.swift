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
        // Set the custom logoImage as the navigation item's titleView
        navigationItem.titleView = logoImage

        view.backgroundColor = .color2

        // Create a vertical stack view for the username and password text fields
        let textFieldsStackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = Padding.m

        // Create a vertical stack view for the text fields stack and login button
        let stackView = UIStackView(arrangedSubviews: [textFieldsStackView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = Padding.xl
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Add the stack view to the view hierarchy
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.xl),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.m)
        ])
    }

    // TODO: To remove
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        usernameTextField.text = "test+ios2@moneyboxapp.com"
    //        passwordTextField.text = "P455word12"
    //        loginButtonTapped()
    //    }

    // MARK: - Actions

    @objc func loginButtonTapped() {
        if let email = usernameTextField.text,
           let password = passwordTextField.text {
            viewModel?.login(email: email, password: password)
        }
    }
}
