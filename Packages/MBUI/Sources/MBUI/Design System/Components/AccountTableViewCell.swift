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

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .color1
        return imageView
    }()

    private let roundedRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .color1.withAlphaComponent(0.3)
        return view
    }()

    // MARK: - Init

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: - Methods

    private func setupUI() {
        contentView.addSubview(roundedRectangle)

        // Add subviews to the outer view
        roundedRectangle.addSubview(titleLabel)
        roundedRectangle.addSubview(planValueLabel)
        roundedRectangle.addSubview(moneyboxLabel)
        roundedRectangle.addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            // Outer view constraints (to contentView)
            roundedRectangle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            roundedRectangle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roundedRectangle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            roundedRectangle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            // Inner view (content) constraints
            titleLabel.topAnchor.constraint(equalTo: roundedRectangle.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: roundedRectangle.leadingAnchor, constant: 16),

            planValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            planValueLabel.leadingAnchor.constraint(equalTo: roundedRectangle.leadingAnchor, constant: 16),

            moneyboxLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: 4),
            moneyboxLabel.leadingAnchor.constraint(equalTo: roundedRectangle.leadingAnchor, constant: 16),
            moneyboxLabel.bottomAnchor.constraint(equalTo: roundedRectangle.bottomAnchor, constant: -8),

            // Arrow imageView constraints
            arrowImageView.centerYAnchor.constraint(equalTo: roundedRectangle.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: roundedRectangle.trailingAnchor, constant: -16)
        ])
    }

    public func configure(title: String, planValue: String, moneybox: String) {
        titleLabel.text = title
        planValueLabel.text = "Plan Value: \(planValue)"
        moneyboxLabel.text = "Moneybox: \(moneybox)"
    }
}
