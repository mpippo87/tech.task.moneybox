//
//  AccountViewController.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import MBUI
import UIKit

final class AccountViewController: UIViewController {

    // MARK: - Properties

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let planValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let moneyboxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add £10", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()

    var viewModel: AccountViewModelProtocol?

    // MARK: - Init

    init(viewModel: AccountViewModelProtocol?) {
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

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .white

        setupLabels()
        setupButton()

        // Update labels
        titleLabel.text = viewModel?.accountTitle
        planValueLabel.text = "Plan Value: £\(viewModel?.planValue ?? "")"
        moneyboxLabel.text = "Moneybox: £\(viewModel?.moneybox ?? "")"
    }

    // MARK: - Button Action

    @objc private func buttonTapped() {
        // Handle button tap action here
    }

    private func setupLabels() {
        view.addSubview(titleLabel)
        view.addSubview(planValueLabel)
        view.addSubview(moneyboxLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            planValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            planValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            moneyboxLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: 8),
            moneyboxLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    private func setupButton() {
        view.addSubview(actionButton)

        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: moneyboxLabel.bottomAnchor, constant: 16),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}
