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
        label.font = Font.bodyBold
        return label
    }()

    let totalPlanValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.bodyRegular
        return label
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let activityIndicator: ActivityIndicator = .init()

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }

    func update() {
        Task {
            activityIndicator.startAnimating()
            await viewModel?.fetchAccounts { [weak self] in
                self?.updateUI()
            }
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
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.reusableIdentifier)

        // ActivityIndicator
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.isHidden = false
        view.bringSubviewToFront(activityIndicator)
    }

    private func updateUI() {
        Task {
            nameLabel.text = viewModel?.nameLabelText
            totalPlanValueLabel.text = viewModel?.totalPlanValueLabelText
            tableView.reloadData()
            activityIndicator.stopAnimating()
        }
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
