//
//  CheckOutViewModel.swift
//  applogist_case
//
//  Created by Sercan KAYA on 31.07.2022.
//

import Foundation

protocol CheckOutViewDataSource {
    var numberOfRowsInSection: Int { get }
    
    func cellForRowAt(indexPath: IndexPath) -> ProductTableViewCellProtocol?
}

protocol CheckOutViewEventSource {
    var reloadData: VoidClosure? { get set }
    var updateTotalCount: AnyClosure<Double>? { get set }
    var checkOutStatus: BoolClosure? { get set }
}

protocol CheckOutViewProtocol: CheckOutViewDataSource, CheckOutViewEventSource {
    func viewDidLoad()
    func deleteButtonTapped()
    func plusButtonTapped(count: Int, cellItem: ProductTableViewCellProtocol?)
    func deleteButtonTapped(count: Int, cellItem: ProductTableViewCellProtocol?)
    func showAlert()
}

final class CheckOutViewModel: BaseViewModel<CheckOutRouter>, CheckOutViewProtocol {
    
    // Privates
    private var checkOutData: [CheckOutModel]?
    private var producItems: [ProductTableViewCellProtocol]?
    private var alertViewModel: CustomAlertViewModel?
    
    // CheckOutViewEventSource
    var reloadData: VoidClosure?
    var updateTotalCount: AnyClosure<Double>?
    var checkOutStatus: BoolClosure?
    
    init(router: CheckOutRouter, checkOutData: [CheckOutModel]?) {
        super.init(router: router)
        self.checkOutData = checkOutData
    }
    
    func viewDidLoad() {
        configureCellItem()
    }
    
    var numberOfRowsInSection: Int {
        return producItems?.count ?? 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> ProductTableViewCellProtocol? {
        return producItems?[indexPath.row]
    }
    
    func deleteButtonTapped() {
        alertViewModel = CustomAlertViewModel(destructiveButtonTitle: L10n.CustomAlert.destructiveButtonTitle,
                                              regularButtontitle: L10n.CustomAlert.regularButtonTitle,
                                              alertTitle: L10n.CheckOutView.alertTitle,
                                              alertSubtitle: L10n.CheckOutView.alertSubTitle, isHiddendestructiveButton: false)
        deleteProducts(alertViewModel: alertViewModel)
    }
    
    func showAlert() {
        alertViewModel = CustomAlertViewModel(destructiveButtonTitle: L10n.CustomAlert.destructiveButtonTitle, regularButtontitle: L10n.CheckOutView.regularButtonTitle, alertTitle: L10n.CheckOutView.alertTitle, alertSubtitle: L10n.CheckOutView.alertSubTitle, isHiddendestructiveButton: true)
        guard let alertViewModel = alertViewModel else { return }
        router.showCustomAlertView(viewmodel: alertViewModel)
    }
    
    func plusButtonTapped(count: Int, cellItem: ProductTableViewCellProtocol?) {
        producItems = producItems?.map({ productItem in
            if productItem.id == cellItem?.id {
                productItem.count = count
            }
            return productItem
        })
        notifyTotalCount()
        reloadData?()
    }
    
    func deleteButtonTapped(count: Int, cellItem: ProductTableViewCellProtocol?) {
        guard let cellItem = cellItem else { return }
        if count == 0 {
            producItems?.removeAll(where: { $0.id == cellItem.id })
        } else {
            producItems = producItems?.map({ productItem in
                if productItem.id == cellItem.id {
                    productItem.count = count
                }
                return productItem
            })
        }
        notifyTotalCount()
        reloadData?()
    }
}

// MARK: - ConfigureContents
extension CheckOutViewModel {
    
    private func configureCellItem() {
        guard let checkOutData = checkOutData else { return }
        let item = checkOutData.map({ item -> ProductTableViewCellModel in
            return ProductTableViewCellModel(image: item.image, title: item.title, price: item.price, currency: item.currency, id: item.id, stock: item.stock, count: item.count )
        })
        producItems = item
        notifyTotalCount()
        reloadData?()
    }
    
    private func deleteProducts(alertViewModel: CustomAlertViewModel?) {
        guard let viewModel = alertViewModel else { return }
        viewModel.deleteButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.producItems?.removeAll()
            self.notifyTotalCount()
            self.reloadData?()
        }
        router.showCustomAlertView(viewmodel: viewModel)
    }
    
    private func notifyTotalCount() {
        var totalCount: Double = 0
        producItems?.forEach({ item in
            totalCount += Double(item.count ?? 0) * (item.price ?? 0)
        })
        updateTotalCount?(totalCount.round(to: 2))
    }
}

// MARK: - DataProvider
extension CheckOutViewModel {
    
    public func checkOut() {
        let items = producItems?.map({ CheckOutItem(id: $0.id, amount: $0.count) })
        let request = CheckOutRequest(items: items)
        dataProvider?.request(for: request, result: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                let viewModel = CustomAlertViewModel(destructiveButtonTitle: "Kapat", regularButtontitle: "Kapat", alertTitle: "BİLGİ", alertSubtitle: model.message ?? "", isHiddendestructiveButton: true)
                self.router.showCustomAlertView(viewmodel: viewModel)
                self.producItems?.removeAll()
                self.notifyTotalCount()
                self.checkOutStatus?(true)
                self.reloadData?()
            case .failure(_):
                self.checkOutStatus?(false)
                let viewModel = CustomAlertViewModel(destructiveButtonTitle: "Kapat", regularButtontitle: "Tamam", alertTitle: "HATA", alertSubtitle: "Bir şeyler ters gitti lütfen tekrar deneyiniz.", isHiddendestructiveButton: false)
                self.router.showCustomAlertView(viewmodel: viewModel)
            }
        })
    }
}
