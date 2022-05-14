//
//  BaseNavigationController.swift
//  NYT
//
//  Created by Ercan Garip on 7.12.2021.
//

import UIKit
import UIComponents

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configureContents() {
        let attributed: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.black]
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            let backButtonAppearance = UIBarButtonItemAppearance()
            backButtonAppearance.normal.titleTextAttributes = attributed
            
            appearance.backButtonAppearance = backButtonAppearance
            appearance.backgroundColor = .red
            appearance.titleTextAttributes = attributed
            appearance.largeTitleTextAttributes = attributed

            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .red
            UINavigationBar.appearance().isTranslucent = false
        }

    }
}
