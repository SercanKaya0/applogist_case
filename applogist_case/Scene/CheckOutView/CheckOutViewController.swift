//
//  CheckOutViewController.swift
//  applogist_case
//
//  Created by Sercan KAYA on 31.07.2022.
//

import UIKit
import UIComponents

protocol CheckOutViewControllerDelegate: AnyObject {
    func didDelete(id: String?, count: Int)
    func didAppend(id: String?, count: Int)
    func didRemoveAllItems()
}

final class CheckOutViewController: BaseViewController<CheckOutViewModel> {
    
    weak var delegate: CheckOutViewControllerDelegate?
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.contentInset = .zero
        tableView.backgroundColor = .white
        tableView.allowsMultipleSelection = true
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProductTableViewCell.self)
        return tableView
    }()
    
    private let bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .appLightGreen
        return bottomView
    }()
    
    private let totalNameLabel: UILabel = {
        let totalNameLabel = UILabel()
        totalNameLabel.font = .systemFont(ofSize: 20)
        return totalNameLabel
    }()
    
    private let totalCountLabel: UILabel = {
        let totalCountLabel = UILabel()
        totalCountLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        return totalCountLabel
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appBlue
        button.contentEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        configureLocalize()
        subscribeViewModel()
        viewModel.viewDidLoad()
    }
}

// MARK: - UILayout
extension CheckOutViewController {
    
    private func addSubViews() {
        addTableView()
        addBottomView()
        addTotalStackView()
        addConfirmButton()
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(excluding: .bottom)
    }
    
    private func addBottomView() {
        view.addSubview(bottomView)
        bottomView.topToBottom(of: tableView)
        bottomView.edgesToSuperview(excluding: .top, usingSafeArea: true)
        bottomView.height(90)
    }
    
    private func addTotalStackView() {
        bottomView.addSubview(totalStackView)
        totalStackView.centerYToSuperview()
        totalStackView.leadingToSuperview(offset: 16)
        totalStackView.addArrangedSubview(totalNameLabel)
        totalStackView.addArrangedSubview(totalCountLabel)
    }
    
    private func addConfirmButton() {
        bottomView.addSubview(confirmButton)
        confirmButton.height(40)
        confirmButton.centerY(to: totalStackView)
        confirmButton.trailingToSuperview(offset: 16)
    }
}

// MARK: - ConfigureContents
extension CheckOutViewController {
    
    private func configureContents() {
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        configureTableView()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = L10n.CheckOutView.navigationTitle
        let barButton = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItem = barButton
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: deleteButton)
        navigationItem.leftBarButtonItem = leftBarButton
        deleteButton.addTarget(self, action: #selector(removeAllButtonTapped), for: .touchUpInside)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - ConfigureLocalize
extension CheckOutViewController {
    
    private func configureLocalize() {
        deleteButton.setTitle(L10n.CheckOutView.deleteButtonTitle, for: .normal)
        closeButton.setTitle(L10n.CheckOutView.closeButtonTitle, for: .normal)
        totalNameLabel.text = L10n.CheckOutView.priceLabelTitle
        confirmButton.setTitle(L10n.CheckOutView.confirmButtonTitle, for: .normal)
    }
}

// MARK: - SubscribeViewModel
extension CheckOutViewController {
    
    private func subscribeViewModel() {
        
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        viewModel.updateTotalCount = { [weak self] count in
            guard let self = self else { return }
            self.totalCountLabel.text = "₺\(count)"
            if count <= 0 {
                self.confirmButton.isEnabled = false
                self.confirmButton.backgroundColor = .lightGray
            } else {
                self.confirmButton.backgroundColor = .appBlue
                self.confirmButton.isEnabled = true
            }
        }
        
        viewModel.checkOutStatus = { [weak self] status in
            guard let self = self else { return }
            if status {
                self.delegate?.didRemoveAllItems()
            }
        }
    }
}

// MARK: - Actions
extension CheckOutViewController {
    
    @objc
    private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func removeAllButtonTapped() {
        viewModel.deleteButtonTapped()
        delegate?.didRemoveAllItems()
    }
    
    @objc
    private func confirmButtonTapped() {
        viewModel.checkOut()
    }
}

// MARK: - UITableView Delegate
extension CheckOutViewController: UITableViewDelegate {
    
}

// MARK: - UITableView DataSource
extension CheckOutViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let viewModel = viewModel.cellForRowAt(indexPath: indexPath) {
            cell.set(viewModel: viewModel)
            cell.delegate = self
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - ProductTableViewCellDelegate
extension CheckOutViewController: ProductTableViewCellDelegate {
    
    func plusButtonTapped(count: Int, cellItem: ProductTableViewCellProtocol?) {
        viewModel.plusButtonTapped(count: count, cellItem: cellItem)
        delegate?.didAppend(id: cellItem?.id, count: count)
    }
    
    func deleteButtonTapped(count: Int, cellItem: ProductTableViewCellProtocol?) {
        viewModel.deleteButtonTapped(count: count, cellItem: cellItem)
        delegate?.didDelete(id: cellItem?.id, count: count)
    }
    
    func showAlert() {
        viewModel.showAlert()
    }
}
