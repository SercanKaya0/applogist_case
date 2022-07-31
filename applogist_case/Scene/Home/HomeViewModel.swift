//
//  HomeViewModel.swift
//  applogist_case
//
//  Created by Sercan KAYA on 29.07.2022.
//

import Foundation
import SwiftEntryKit
import Utilities
import DataProvider
import UIComponents

protocol HomeViewDataSource {
    var numberOfItemsInSection: Int { get }
}

protocol HomeViewEventSource {
    var reloadData: VoidClosure? { get set }
    var setBasketCount: IntClosure? { get set }
}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    func viewDidLoad(viewController: HomeViewController?)
    func productCellModel(indexPath: IndexPath) -> ProductCellProtocol?
    func pushCheckOut()
    func plusButtonTapped(count: Int, cellItem: ProductCellProtocol?)
    func deleteButtonTapped(count: Int, cellItem: ProductCellProtocol?)
    func showAlert()
    func didDelete(id: String?, count: Int)
    func didAppend(id: String?, count: Int)
    func didRemoveAllItems()
}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
    private var productCellItem: [ProductCellProtocol]?
    private var producItems: [CheckOutModel] = []
    private var alertViewModel: CustomAlertViewModel?
    private var viewController: HomeViewController?
    
    var reloadData: VoidClosure?
    var setBasketCount: IntClosure?
    
    func viewDidLoad(viewController: HomeViewController?) {
        self.viewController = viewController
        getProductList()
    }
    
    var basketItemCount: Int {
        return producItems.count
    }
    
    var numberOfItemsInSection: Int {
        return productCellItem?.count ?? 0
    }
    
    func productCellModel(indexPath: IndexPath) -> ProductCellProtocol? {
        return productCellItem?[indexPath.row]
    }
    
    func pushCheckOut() {
        router.pushCheckOut(checkOutData: producItems, delegate: viewController)
    }
    
    func plusButtonTapped(count: Int, cellItem: ProductCellProtocol?) {
        guard let cellItem = cellItem else { return }
        let basketCheck = producItems.contains(where: { $0.id == cellItem.id })
        if basketCheck {
            producItems = producItems.map({ item in
                var item = item
                if item.id == cellItem.id {
                    item.count = count
                }
                return item
            })
        } else {
            let item = CheckOutModel(image: cellItem.image, id: cellItem.id, price: cellItem.price, title: cellItem.title, count: count, currency: cellItem.currency, stock: cellItem.stock)
            producItems.append(item)
        }
        setBasketCount?(producItems.count)
    }
    
    func deleteButtonTapped(count: Int, cellItem: ProductCellProtocol?) {
        guard let cellItem = cellItem else { return }
        if count > 0 {
            producItems = producItems.map({ item in
                var item = item
                if item.id == cellItem.id {
                    item.count = count
                }
                return item
            })
        } else {
            producItems.removeAll(where: { $0.id == cellItem.id })
        }
        setBasketCount?(producItems.count)
    }
    
    func showAlert() {
        alertViewModel = CustomAlertViewModel(destructiveButtonTitle: L10n.CustomAlert.destructiveButtonTitle, regularButtontitle: L10n.HomeView.regularButtonTitle, alertTitle: L10n.HomeView.alertTitle, alertSubtitle: L10n.HomeView.alertSubTitle, isHiddendestructiveButton: true)
        guard let alertViewModel = alertViewModel else { return }
        router.showCustomAlertView(viewmodel: alertViewModel)
    }
    
    func didDelete(id: String?, count: Int) {
        productCellItem = productCellItem?.map({ productCellItem in
            if productCellItem.id == id {
                if count == 0 {
                    productCellItem.updateCount(count: count)
                    producItems.removeAll(where: { $0.id == id })
                } else {
                    productCellItem.updateCount(count: count)
                    producItems = producItems.map({ checkOutItem in
                        var item = checkOutItem
                        if item.id == id {
                            item.count -= 1
                        }
                        return item
                    })
                }
            }
            return productCellItem
        })
        setBasketCount?(producItems.count)
        reloadData?()
    }
    
    func didAppend(id: String?, count: Int) {
        productCellItem = productCellItem?.map({ productCellItem in
            if productCellItem.id == id {
                productCellItem.updateCount(count: count)
                producItems = producItems.map({ checkOutItem in
                    var item = checkOutItem
                    if item.id == id {
                        item.count += 1
                    }
                    return item
                })
            }
            return productCellItem
        })
        setBasketCount?(producItems.count)
        reloadData?()
    }
    
    func didRemoveAllItems() {
        producItems.removeAll()
        productCellItem = productCellItem?.map({ item in
            item.updateCount(count: 0)
            return item
        })
        setBasketCount?(producItems.count)
        reloadData?()
    }
}

// MARK: - ConfigureContents
extension HomeViewModel {
    
    private func configureHomeCell(data: [Home]?) {
        guard let data = data else { return }
        let item = data.map({ ProductCellModel(image: $0.imageURL, title: $0.name, price: $0.price, currency: $0.currency, id: $0.id, stock: $0.stock) })
        productCellItem = item
    }
}

// MARK: - Requests
extension HomeViewModel {
    
    private func getProductList() {
        let request = HomeRequest()
        self.dataProvider?.request(for: request, result: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.configureHomeCell(data: response)
                self.reloadData?()
            case .failure(let error):
                print(error)
            }
        })
    }
}
