//
//  FloatPresenter.swift
//  applogist_case
//
//  Created by Sercan KAYA on 31.07.2022.
//

import SwiftEntryKit

final class FloatPresenter {
        
    static private func getFloatAttributes() -> EKAttributes {
        var attributes = EKAttributes.centerFloat
        attributes.positionConstraints.safeArea = .overridden
        attributes.positionConstraints.maxSize = .init(width: .offset(value: 40), height: .offset(value: 30))
        attributes.displayDuration = .infinity
        attributes.entryInteraction.defaultAction = .absorbTouches
        attributes.screenBackground = .color(color: EKColor(UIColor.black.withAlphaComponent(0.4)))
        attributes.hapticFeedbackType = .none
        attributes.screenInteraction = .dismiss
        attributes.entranceAnimation = .none
        attributes.exitAnimation = .none
        attributes.popBehavior = .overridden
        let keyboardRelation = EKAttributes.PositionConstraints.KeyboardRelation.bind(offset: .none)
        attributes.positionConstraints.keyboardRelation = keyboardRelation
        return attributes
    }
    
    static func showCustomAlert(viewModel: CustomAlertViewProtocol) {
        let attributes = getFloatAttributes()
        let view = CustomAlertView()
        view.set(viewModel: viewModel)
        SwiftEntryKit.display(entry: view, using: attributes)
    }
}
