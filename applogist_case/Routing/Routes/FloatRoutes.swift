//
//  FloatRoutes.swift
//  applogist_case
//
//  Created by Sercan KAYA on 31.07.2022.
//

import Foundation

import Foundation

protocol FloatRoute {
    func showCustomAlertView(viewmodel: CustomAlertViewProtocol)
}

extension FloatRoute where Self: RouterProtocol {
    
    func showCustomAlertView(viewmodel: CustomAlertViewProtocol) {
        FloatPresenter.showCustomAlert(viewModel: viewmodel)
    }
}
