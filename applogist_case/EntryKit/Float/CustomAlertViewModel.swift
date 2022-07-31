//
//  CustomAlertViewModel.swift
//  applogist_case
//
//  Created by Sercan KAYA on 31.07.2022.
//

import Foundation

public protocol CustomAlertViewDataSource: AnyObject {
    var isHiddenImage: Bool { get set }
    var destructiveButtonTitle: String { get set }
    var regularButtontitle: String { get set }
    var alertTitle: String { get set }
    var alertSubtitle: String { get set }
    var isHiddendestructiveButton: Bool { get set }
}

public protocol CustomAlertViewEventSource: AnyObject {
    var deleteButtonTapped: VoidClosure? { get set }
}

public protocol CustomAlertViewProtocol: CustomAlertViewDataSource, CustomAlertViewEventSource {
    
}

public final class CustomAlertViewModel: CustomAlertViewProtocol {
    
    public var deleteButtonTapped: VoidClosure?
    public var isHiddenImage: Bool
    public var destructiveButtonTitle: String
    public var regularButtontitle: String
    public var alertTitle: String
    public var alertSubtitle: String
    public var isHiddendestructiveButton: Bool
    
    public init(isHiddenImage: Bool = false, destructiveButtonTitle: String, regularButtontitle: String, alertTitle: String, alertSubtitle: String, isHiddendestructiveButton: Bool) {
        self.destructiveButtonTitle = destructiveButtonTitle
        self.regularButtontitle = regularButtontitle
        self.alertTitle = alertTitle
        self.alertSubtitle = alertSubtitle
        self.isHiddenImage = isHiddenImage
        self.isHiddendestructiveButton = isHiddendestructiveButton
    }
}
