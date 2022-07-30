//
//  HomeViewController.swift
//  applogist_case
//
//  Created by Sercan KAYA on 29.07.2022.
//

import UIKit
import UIComponents

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private let collectionView: UICollectionView = {
        let fraction: CGFloat = 1 / 3
        let item = NSCollectionLayoutSupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        group.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCell.self)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let basketButton: BigAreaButton = {
        let button = BigAreaButton()
        button.setImage(.imgBasket, for: .normal)
        button.size(.init(width: 16, height: 16))
        return button
    }()
    
    private let badgeView = BadgeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        subscribeViewModel()
        viewModel.viewDidLoad()
    }
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubViews() {
        addCollectionView()
        addBadgeView()
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        // NSLAYOUT -> 4 Corner Pinned
        collectionView.edgesToSuperview()
    }
    
    private func addBadgeView() {
        basketButton.addSubview(badgeView)
        badgeView.topToSuperview(offset: -6)
        badgeView.trailingToSuperview(offset: -12)
    }
}

// MARK: - ConfigureContents
extension HomeViewController {
    
    private func configureContents() {
        configureCollectionView()
        configureNavigationBar()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func configureNavigationBar() {
        navigationItem.title = L10n.HomeView.navigationTitle
        let barButton = UIBarButtonItem(customView: basketButton)
        navigationItem.rightBarButtonItem = barButton
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
    }
}

// MARK: - SubscribeViewModel
extension HomeViewController {
    
    private func subscribeViewModel() {
        
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        
        viewModel.countState = { [weak self] state in
            guard let self = self else { return }
            print(state)
            if state == .plus {
                self.badgeView.basketCount += 1
            } else {
                self.badgeView.basketCount -= 1
            }
        }
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc
    private func basketButtonTapped() {
        viewModel.pushCheckOut()
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCell = collectionView.dequeueReusableCell(for: indexPath)
        if let viewModel = viewModel.productCellModel(indexPath: indexPath) {
            cell.delegate = self
            cell.set(viewModel: viewModel)
        }
        return cell
    }
}

// MARK: - StepperViewDelegate
extension HomeViewController: StepperViewDelegate {
   
    func countState(tappedState: TappedState) {
        viewModel.countState(tappedState: tappedState)
    }
}
