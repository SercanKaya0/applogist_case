//
//  StepperView.swift
//  UIComponents
//
//  Created by Sercan KAYA on 29.07.2022.
//

import UIKit

public protocol StepperViewDelegate: AnyObject {
    func plusButtonTapped(count: Int)
    func deleteButtonTapped(count: Int)
    func showAlert()
}

public class StepperView: UIView {
    
    private let plusButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    private let countLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .appBlue.withAlphaComponent(0.3)
        return label
    }()
    
    private let deleteButton: UIButton = {
       let button = UIButton()
        button.setImage(.imgLine.withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    public weak var delegate: StepperViewDelegate?
    
    private var stockCount: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }
    
    public var count: Int = 0 {
        didSet {
            configureCountLabel()
            configureButtons()
        }
    }
    
    public var stock: Int = 0 {
        willSet {
            stockCount = newValue
        }
    }
}

// MARK: - UILayout
extension StepperView {
    
    private func addSubViews() {
        addDeleteButton()
        addCountLabel()
        addPlusButton()
    }
    
    private func addDeleteButton() {
        addSubview(deleteButton)
        deleteButton.size(.init(width: 32, height: 24))
        deleteButton.leadingToSuperview()
        deleteButton.imageEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    private func addCountLabel() {
        addSubview(countLabel)
        countLabel.edgesToSuperview(excluding: [.leading, .trailing])
        countLabel.leadingToTrailing(of: deleteButton)
    }
    
    private func addPlusButton() {
        addSubview(plusButton)
        plusButton.size(.init(width: 24, height: 24))
        plusButton.trailingToSuperview()
        plusButton.leadingToTrailing(of: countLabel)
    }
}

// MARK: - ConfigureContents
extension StepperView {
    
    private func configureContents() {
        count = 0
        configureCountLabel()
    }
    
    private func configureCountLabel() {
        countLabel.text = "\(count)"
    }
    
    private func configureButtons() {
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        if count > 0 {
            deleteButton.isHidden = false
            countLabel.isHidden = false
        } else {
            deleteButton.isHidden = true
            countLabel.isHidden = true
        }
    }
}

// MARK: - Actions
extension StepperView {
    
    @objc
    private func plusButtonTapped() {
        if count <= stockCount {
            self.count += 1
            delegate?.plusButtonTapped(count: count)
        } else {
            delegate?.showAlert()
        }
    }
    
    @objc
    private func deleteButtonTapped() {
        if count > 0 {
            self.count -= 1
            delegate?.deleteButtonTapped(count: count)
        }
    }
}
