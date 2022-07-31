//
//  CheckOutRoute.swift
//  applogist_case
//
//  Created by Sercan KAYA on 31.07.2022.
//

protocol CheckOutRoute {
    func pushCheckOut(checkOutData: [CheckOutModel]?, delegate: CheckOutViewControllerDelegate?)
}

extension CheckOutRoute where Self: RouterProtocol {
    
    func pushCheckOut(checkOutData: [CheckOutModel]?, delegate: CheckOutViewControllerDelegate?) {
        let router = CheckOutRouter()
        let viewModel = CheckOutViewModel(router: router, checkOutData: checkOutData)
        let viewController = CheckOutViewController(viewModel: viewModel)
        viewController.delegate = delegate
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
