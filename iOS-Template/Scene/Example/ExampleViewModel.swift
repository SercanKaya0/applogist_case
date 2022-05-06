//
//  ExampleViewModel.swift
//  iOS-Template
//
//  Created by Ercan Garip on 6.05.2022.
//

import Foundation

protocol ExampleViewDataSource {}

protocol ExampleViewEventSource {}

protocol ExampleViewProtocol: ExampleViewDataSource, ExampleViewEventSource {}

final class ExampleViewModel: BaseViewModel<ExampleRouter>, ExampleViewProtocol {
    
}
