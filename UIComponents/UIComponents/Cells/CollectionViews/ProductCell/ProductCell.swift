//
//  ProductCell.swift
//  UIComponents
//
//  Created by Sercan KAYA on 29.07.2022.
//

import UIKit
import TinyConstraints
import Kingfisher

public protocol ProductCellDelegate: AnyObject {
    func plusButtonTapped(cellItem: ProductCellProtocol)
    func deleteButtonTapped(cellItem: ProductCellProtocol)
}

public class ProductCell: UICollectionViewCell, ReusableView {
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = .appBlue
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let stepperView = StepperView()
    
    weak var viewModel: ProductCellProtocol?
    public weak var delegate: StepperViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }
    
    public func set(viewModel: ProductCellProtocol) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension ProductCell {
    
    private func addSubViews() {
        addStepperView()
        addImageView()
        addPriceLabel()
        addTitleLabel()
    }
       
    private func addStepperView() {
        contentView.addSubview(stepperView)
        stepperView.edgesToSuperview(excluding: [.bottom, .leading])
        stepperView.width(bounds.width * 0.70)
        stepperView.height(24)
    }
    
    private func addImageView() {
        contentView.addSubview(imageView)
        imageView.edgesToSuperview(excluding: [.bottom, .top])
        imageView.topToBottom(of: stepperView, offset: 8)
    }
    
    private func addPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.edgesToSuperview(excluding: [.top, .bottom], insets: .horizontal(8))
        priceLabel.topToBottom(of: imageView, offset: 8)
    }
    
    private func addTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: .top, insets: .horizontal(8) + .bottom(8))
        titleLabel.topToBottom(of: priceLabel, offset: 8)
    }
}


// MARK: - ConfigureContents
extension ProductCell {
    
    private func configureContents() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        configureImageView()
        configurePriceLabel()
        configureTitleLabel()
        configureStepperView()
    }
    
    private func configureImageView() {
        guard let url = viewModel?.image else { return }
        imageView.kf.setImage(with: url.caseURL)
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
        stepperView.delegate = delegate
    }
}
