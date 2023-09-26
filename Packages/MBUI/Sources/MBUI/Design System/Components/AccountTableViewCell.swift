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

    private let chevronImageView: UIImageView = {
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

        roundedRectangle.addSubview(titleLabel)
        roundedRectangle.addSubview(planValueLabel)
        roundedRectangle.addSubview(moneyboxLabel)
        roundedRectangle.addSubview(chevronImageView)

        NSLayoutConstraint.activate([
            roundedRectangle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Padding.s),
            roundedRectangle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Padding.m),
            roundedRectangle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Padding.m),
            roundedRectangle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Padding.s),
            titleLabel.topAnchor.constraint(equalTo: roundedRectangle.topAnchor, constant: Padding.s),
            titleLabel.leadingAnchor.constraint(equalTo: roundedRectangle.leadingAnchor, constant: Padding.m),
            planValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Padding.xs),
            planValueLabel.leadingAnchor.constraint(equalTo: roundedRectangle.leadingAnchor, constant: Padding.m),
            moneyboxLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: Padding.xs),
            moneyboxLabel.leadingAnchor.constraint(equalTo: roundedRectangle.leadingAnchor, constant: Padding.m),
            moneyboxLabel.bottomAnchor.constraint(equalTo: roundedRectangle.bottomAnchor, constant: -Padding.s),
            chevronImageView.centerYAnchor.constraint(equalTo: roundedRectangle.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: roundedRectangle.trailingAnchor, constant: -Padding.m)
        ])
    }

    public func configure(title: String, planValue: String, moneybox: String) {
        titleLabel.text = title
        planValueLabel.text = "Plan Value:  £\(planValue)"
        moneyboxLabel.text = "Moneybox:  £\(moneybox)"
    }
}
