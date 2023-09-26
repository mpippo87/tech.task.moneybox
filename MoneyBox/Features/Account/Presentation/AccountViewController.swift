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

    private let addButton: Button = .init(title: "Add £10",
                                          style: .secondary,
                                          target: self,
                                          action: #selector(addButtonTapped))

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
        updateUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        title = "Individual Account"

        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(planValueLabel)
        view.addSubview(moneyboxLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.m),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),

            planValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Padding.s),
            planValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),

            moneyboxLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: Padding.s),
            moneyboxLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m)
        ])

        // Button
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: moneyboxLabel.bottomAnchor, constant: Padding.m),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.m),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func updateUI() {
        titleLabel.text = viewModel?.accountTitle
        planValueLabel.text = "Plan Value: £\(viewModel?.planValue ?? "")"
        moneyboxLabel.text = "Moneybox: £\(viewModel?.moneybox ?? "")"
    }

    // MARK: - Methods

    @objc func addButtonTapped() {
        Task {
            viewModel?.addTenPounds()
            await MainActor.run {
                moneyboxLabel.text = "Moneybox: £\(viewModel?.moneybox ?? "")"
            }
        }
    }
}
