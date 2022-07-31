//
//  CustomAlertView.swift
//  applogist_case
//
//  Created by Sercan KAYA on 31.07.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints
import SwiftEntryKit

public class CustomAlertView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let topDivider: UIView = {
        let view = UIView()
        return view
    }()
    
    private let bottomDivider: UIView = {
        let view = UIView()
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private let descructiveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 0
        return button
    }()
        
    private let regularButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 0
        return button
    }()
    
    private weak var viewModel: CustomAlertViewProtocol?
    
    private var imageSize: CGSize = .init(width: 24, height: 24)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
        setLocalize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func set(viewModel: CustomAlertViewProtocol) {
        self.viewModel = viewModel
        configureContents()
        setLocalize()
    }
}

// MARK: - UI Layout
extension CustomAlertView {
    
    private func addSubViews() {
        addImageView()
        addTitleLabel()
        addSubtitleLabel()
        addTopDividerView()
        addStackView()
    }
    
    private func addImageView() {
        addSubview(imageView)
        imageView.topToSuperview(offset: 16)
        imageView.leadingToSuperview(offset: 16)
    }
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topToSuperview(offset: 16)
        titleLabel.leadingToTrailing(of: imageView, offset: 8)
        titleLabel.trailingToSuperview(offset: 16)
    }
    
    private func addSubtitleLabel() {
        addSubview(subTitleLabel)
        subTitleLabel.leading(to: titleLabel)
        subTitleLabel.trailing(to: titleLabel)
        subTitleLabel.topToBottom(of: titleLabel, offset: 8)
    }
    
    private func addTopDividerView() {
        addSubview(topDivider)
        topDivider.topToBottom(of: subTitleLabel, offset: 8)
        topDivider.horizontalToSuperview()
    }
    
    private func  addStackView() {
        addSubview(stackView)
        stackView.topToBottom(of: topDivider)
        stackView.horizontalToSuperview()
        stackView.bottomToSuperview(offset: -8)
        stackView.addArrangedSubview(descructiveButton)
        stackView.addArrangedSubview(bottomDivider)
        stackView.addArrangedSubview(regularButton)
    }
    
    private func addDescructiveButton() {
        addSubview(descructiveButton)
        descructiveButton.topToBottom(of: topDivider)
        descructiveButton.horizontalToSuperview()
        descructiveButton.height(50)
    }
    
    private func addBottomDividerView() {
        addSubview(bottomDivider)
        bottomDivider.topToBottom(of: descructiveButton)
        bottomDivider.horizontalToSuperview()
    }
    
    private func addRegularButton() {
        addSubview(regularButton)
        regularButton.topToBottom(of: bottomDivider)
        regularButton.horizontalToSuperview()
        regularButton.height(50)
        regularButton.bottomToSuperview(offset: -8)
    }
}

// MARK: - Configure
extension CustomAlertView {
    
    private func configureContents() {
        regularButton.addTarget(self, action: #selector(regularButtonTapped), for: .touchUpInside)
        regularButton.setTitleColor(.gray, for: .normal)
        regularButton.setTitleColor(.gray, for: .highlighted)
        descructiveButton.addTarget(self, action: #selector(descructiveButtonTapped), for: .touchUpInside)
        descructiveButton.setTitleColor(.red, for: .normal)
        descructiveButton.setTitleColor(.red, for: .highlighted)
        backgroundColor = .white
        layer.cornerRadius = 12
        guard let viewModel = viewModel else { return }
        imageView.tintColor = .red
        imageView.image = UIImage(systemName: "")?.withRenderingMode(.alwaysTemplate)
        imageSize = viewModel.isHiddenImage ? .zero : .init(width: 24, height: 25)
        imageView.size(imageSize)
        descructiveButton.isHidden = viewModel.isHiddendestructiveButton
    }
    
    private func setLocalize() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.alertTitle
        subTitleLabel.text = viewModel.alertSubtitle
        descructiveButton.setTitle(viewModel.destructiveButtonTitle, for: .normal)
        regularButton.setTitle(viewModel.regularButtontitle, for: .normal)
    }
}

// MARK: - Actions
extension CustomAlertView {
    
    @objc
    func descructiveButtonTapped() {
        SwiftEntryKit.dismiss()
        viewModel?.deleteButtonTapped?()
    }
    
    @objc
    func regularButtonTapped() {
        SwiftEntryKit.dismiss()
    }
}
