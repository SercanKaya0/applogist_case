//
//  UICollectionView+Extensions.swift
//  UIComponents
//
//  Created by Ercan Garip on 30.11.2021.
//

import UIKit
import TinyConstraints
import MobilliumBuilders

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeader<T: UICollectionReusableView>(_: T.Type) where T: ReusableView {
        register(T.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerFooter<T: UICollectionReusableView>(_: T.Type) where T: ReusableView {
        register(T.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: T.reuseIdentifier)
    }
    
    // swiftlint:disable fatal_error
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UICollectionReusableView>(ofKind: String, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func setEmptyView(message: String, image: UIImage) {
        let emptyView = UIView()
        emptyView.size(.init(width: bounds.width, height: bounds.height))
        
        let circleView = UIViewBuilder()
            .backgroundColor(.appHoney.withAlphaComponent(0.15))
            .cornerRadius(36)
            .build()
        
        let imageView = UIImageViewBuilder()
            .contentMode(.scaleAspectFit)
            .image(image)
            .build()
        
        let messageLabel = UILabelBuilder()
            .numberOfLines(0)
            .textAlignment(.center)
            .text(message)
            .font(.title)
            .textColor(.appObsidian)
            .build()
        
        emptyView.addSubview(circleView)
        circleView.size(.init(width: 72, height: 72))
        circleView.centerInSuperview()
        
        circleView.addSubview(imageView)
        imageView.size(.init(width: 40, height: 40))
        imageView.centerInSuperview()
        
        emptyView.addSubview(messageLabel)
        messageLabel.topToBottom(of: circleView, offset: XMMargin)
        messageLabel.horizontalToSuperview(insets: .horizontal(XXXLMargin))

        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    // swiftlint:enable fatal_error
    
}
