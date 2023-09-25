//
//  AccountViewController.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import MBUI
import UIKit

final class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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

    var userAccountsData: [(title: String, planValue: String, moneybox: String)] = [] // Your data

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

        view.backgroundColor = .white

        setupTopLabels()
        setupTableView()

        // Update labels and data
        nameLabel.text = "Hello {Name}!" // Replace {Name} with the actual user's name
        totalPlanValueLabel.text = "Total Plan Value: £{total}" // Replace {total} with the actual total value

        // Populate userAccountsData with your data
        userAccountsData = [
            ("Account 1", "1000", "500"),
            ("Account 2", "2000", "1000")
            // Add more data as needed
        ]
    }

    // MARK: - UI Setup

    private func setupTopLabels() {
        view.addSubview(nameLabel)
        view.addSubview(totalPlanValueLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            totalPlanValueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            totalPlanValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: totalPlanValueLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Register the custom cell class
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "account-table-view-cell-identifier")
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userAccountsData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "account-table-view-cell-identifier", for: indexPath) as! AccountTableViewCell

        let data = userAccountsData[indexPath.row]
        cell.configure(title: data.title, planValue: data.planValue, moneybox: data.moneybox)

        return cell
    }
}
