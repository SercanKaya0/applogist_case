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
    var countState: AnyClosure<TappedState>? { get set }
}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    func viewDidLoad()
    func productCellModel(indexPath: IndexPath) -> ProductCellProtocol?
    func countState(tappedState: TappedState)
    func pushCheckOut()
}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
    private var productCellItem: [ProductCellProtocol]?
    
    var reloadData: VoidClosure?
    var countState: AnyClosure<TappedState>?
    
    func viewDidLoad() {
        getProductList()
    }
    
    var numberOfItemsInSection: Int {
        return productCellItem?.count ?? 0
    }
    
    func productCellModel(indexPath: IndexPath) -> ProductCellProtocol? {
        return productCellItem?[indexPath.row]
    }
        
    func countState(tappedState: TappedState) {
        countState?(tappedState)
    }
    
    func pushCheckOut() {
        router.pushCheckOut()
    }
}

// MARK: - ConfigureContents
extension HomeViewModel {
    
    private func configureHomeCell(data: [Home]?) {
        guard let data = data else { return }
        let item = data.map({ ProductCellModel(image: $0.imageURL, title: $0.name, price: $0.price, currency: $0.currency)})
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
