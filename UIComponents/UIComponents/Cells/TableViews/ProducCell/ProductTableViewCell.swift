//
//  ProductTableViewCell.swift
//  UIComponents
//
//  Created by Sercan KAYA on 31.07.2022.
//

import UIKit
import TinyConstraints


public protocol ProductTableViewCellDelegate: AnyObject {
    func plusButtonTapped(count: Int, cellItem: ProductTableViewCellProtocol?)
    func deleteButtonTapped(count: Int, cellItem: ProductTableViewCellProtocol?)
    func showAlert()
}

public class ProductTableViewCell: UITableViewCell, ReusableView {
    
    private let productImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .appBlue
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let stepperView = StepperView()
    
    weak var viewModel: ProductTableViewCellProtocol?
    
    public weak var delegate: ProductTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubViews()
        configureContents()
    }
    
    public func set(viewModel: ProductTableViewCellProtocol) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension ProductTableViewCell {
    
    private func addSubViews() {
        addImageView()
        addTitleLabel()
        addPriceLabel()
        addStepperView()
    }

    private func addImageView() {
        contentView.addSubview(productImage)
        productImage.edgesToSuperview(excluding: [.trailing, .bottom], insets: .vertical(8) + .left(8))
        productImage.size(.init(width: 100, height: 100))
    }
    
    
    private func addTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.leadingToTrailing(of: productImage, offset: 16)
        titleLabel.top(to: productImage, offset: 24)
    }
    
    private func addPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.leading(to: titleLabel)
        priceLabel.trailing(to: titleLabel)
        priceLabel.topToBottom(of: titleLabel, offset: 8)
        priceLabel.bottomToSuperview(offset: -24)
    }
    
    
 private func addStepperView() {
     contentView.addSubview(stepperView)
     stepperView.edgesToSuperview(excluding: [.bottom, .leading, .top], insets: .right(8))
     stepperView.leadingToTrailing(of: titleLabel, offset: 64)
     stepperView.centerYToSuperview()
     stepperView.height(24)
    }
}

// MARK: - ConfigureContents
extension ProductTableViewCell {
    
    private func configureContents() {
        selectionStyle = .none
        configureImageView()
        configurePriceLabel()
        configureTitleLabel()
        configureStepperView()
    }
    
    private func configureImageView() {
        guard let url = viewModel?.image else { return }
        productImage.kf.setImage(with: url.caseURL)
    }
    
    private func configurePriceLabel() {
        guard let price = viewModel?.price, let currency = viewModel?.currency else { return }
        priceLabel.text = "\(currency)\(price)"
    }
    
    private func configureTitleLabel() {
        guard let title = viewModel?.title else { return }
        titleLabel.text = title
    }
    
    private func configureStepperView() {
        stepperView.delegate = self
        guard let stock = viewModel?.stock, let count = viewModel?.count else { return }
        stepperView.stock = stock
        stepperView.count = count
    }
}

// MARK: - StepperViewDelegate
extension ProductTableViewCell: StepperViewDelegate {
    public func showAlert() {
        delegate?.showAlert()
    }
    
    public func plusButtonTapped(count: Int) {
        delegate?.plusButtonTapped(count: count, cellItem: viewModel)
    }
    
    public func deleteButtonTapped(count: Int) {
        delegate?.deleteButtonTapped(count: count, cellItem: viewModel)
    }
}
