//
//  AccountTableViewCell.swift
//  MoneyBox
//
//  Created by Filippo Minelle on 21/09/2023.
//

import UIKit

public final class AccountTableViewCell: UITableViewCell {

    // MARK: - Types

    public static let reusableIdentifier = "account-table-view-cell-identifier"

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

    // MARK: - Init

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: - Methods

    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(planValueLabel)
        contentView.addSubview(moneyboxLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            planValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            planValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            moneyboxLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: 4),
            moneyboxLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            moneyboxLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    public func configure(
        title: String,
        planValue: String,
        moneybox: String
    ) {
        titleLabel.text = title
        planValueLabel.text = "Plan Value: \(planValue)"
        moneyboxLabel.text = "Moneybox: \(moneybox)"
    }
}
