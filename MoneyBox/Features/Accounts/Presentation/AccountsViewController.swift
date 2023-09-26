//
//  AccountsViewController.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import MBUI
import UIKit

final class AccountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let totalPlanValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var viewModel: AccountsViewModelProtocol?

    // MARK: - Init

    init(viewModel: AccountsViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()

        Task {
            await viewModel?.fetchAccounts()
            DispatchQueue.main.async { [weak self] in
                self?.updateUI()
            }
        }
    }

    // TODO: To remove
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel?.didSelectAccount(at: IndexPath(row: 1, section: 0))
        }
    }

    // MARK: - UI Setup

    private func setupUI() {
        title = "Your Accounts"

        view.addSubview(nameLabel)
        view.addSubview(totalPlanValueLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.m),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),

            totalPlanValueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Padding.xs),
            totalPlanValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m)
        ])

        // Table
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: totalPlanValueLabel.bottomAnchor, constant: Padding.m),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.separatorStyle = .none

        // Register the custom cell class
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.reusableIdentifier)
    }

    private func updateUI() {
        nameLabel.text = viewModel?.nameLabelText
        totalPlanValueLabel.text = viewModel?.totalPlanValueLabelText
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.userAccountsData.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.reusableIdentifier, for: indexPath) as! AccountTableViewCell
        if let account = viewModel?.userAccountsData[indexPath.row] {
            cell.configure(title: account.title, planValue: String(account.planValue), moneybox: String(account.moneybox))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectAccount(at: indexPath)
    }
}
