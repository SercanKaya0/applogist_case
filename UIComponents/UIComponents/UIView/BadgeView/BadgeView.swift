//
//  BadgeView.swift
//  UIComponents
//
//  Created by Sercan KAYA on 30.07.2022.
//

import UIKit

public class BadgeView: UIView {
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 8, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }
    
    public var basketCount: Int = 0 {
        didSet {
            titleLabel.text = "\(basketCount)"
        }
    }
}

// MARK: - UILayout
extension BadgeView {
    
    private func addSubViews() {
        addTitleLabel()
    }
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.centerInSuperview()
    }
}

// MARK: - ConfigureContents
extension BadgeView {
    
    private func configureContents() {
        basketCount = 0
        layer.cornerRadius = 10
        backgroundColor = .white
        size(.init(width: 20, height: 20))
        layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        layer.borderWidth = 1
    }
}
