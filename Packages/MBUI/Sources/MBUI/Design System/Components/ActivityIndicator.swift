//
//  ActivityIndicator.swift
//
//
//  Created by Filippo Minelle on 27/09/2023.
//

import UIKit

public class ActivityIndicator: UIActivityIndicatorView {

    // MARK: - Init

    public init() {
        super.init(style: .medium)
        translatesAutoresizingMaskIntoConstraints = false
        hidesWhenStopped = true
        color = .color1
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
