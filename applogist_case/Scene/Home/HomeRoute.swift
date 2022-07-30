//
//  HomeRoute.swift
//  applogist_case
//
//  Created by Sercan KAYA on 29.07.2022.
//

protocol HomeRoute {
    func presentHome()
}

extension HomeRoute where Self: RouterProtocol {
    
    func presentHome() {
        let router = HomeRouter()
        let viewModel = HomeViewModel(router: router)
        let viewController = HomeViewController(viewModel: viewModel)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        let navigationController = BaseNavigationController(rootViewController: viewController)
        
        open(navigationController, transition: transition)
    }
}
