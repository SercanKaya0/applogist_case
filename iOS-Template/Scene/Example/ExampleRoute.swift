//
//  ExampleRoute.swift
//  iOS-Template
//
//  Created by Ercan Garip on 6.05.2022.
//

protocol ExampleRoute {
    func presentExample()
}

extension ExampleRoute where Self: RouterProtocol {
    
    func presentExample() {
        let router = ExampleRouter()
        let viewModel = ExampleViewModel(router: router)
        let viewController = ExampleViewController(viewModel: viewModel)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
