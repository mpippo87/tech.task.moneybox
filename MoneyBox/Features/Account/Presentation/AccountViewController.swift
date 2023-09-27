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
        label.font = Font.bodyBold
        return label
    }()

    let planValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.bodyRegular
        return label
    }()

    let moneyboxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.bodyRegular
        return label
    }()

    let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "£10 added to your account"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.bodyRegular
        label.textColor = .color6
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    private let addButton: Button = .init(title: "Add £10",
                                          style: .secondary,
                                          target: self,
                                          action: #selector(addButtonTapped))

    let activityIndicator: ActivityIndicator = .init()

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
        view.backgroundColor = .color2

        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, planValueLabel, moneyboxLabel])
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.axis = .vertical
        labelsStackView.spacing = Padding.s

        let mainStackView = UIStackView(arrangedSubviews: [labelsStackView, addButton, notificationLabel])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = Padding.l

        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.m),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.m),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.m)
        ])
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func updateUI() {
        titleLabel.text = viewModel?.accountTitle
        planValueLabel.text = viewModel?.planValue
        moneyboxLabel.text = viewModel?.moneybox
    }

    // MARK: - Methods

    @objc func addButtonTapped() {
        activityIndicator.startAnimating()
        Task {
            viewModel?.addTenPounds { [weak self] moneybox in
                if let moneybox {
                    DispatchQueue.main.async {
                        self?.moneyboxLabel.text = "Moneybox: £\(String(describing: moneybox))"
                        self?.notificationLabel.isHidden = false
                        self?.activityIndicator.stopAnimating()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self?.notificationLabel.isHidden = true
                    }
                }
            }
        }
    }
}
