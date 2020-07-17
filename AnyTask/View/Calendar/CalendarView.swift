//
//  CalendarView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

final class CalendarView: UIView {

    private let viewModel: CalendarViewModel
    private let cellId = "cell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        collectionView.backgroundColor = viewModel.backgroundColor
        
        collectionView.isPagingEnabled = true
        
        collectionView.register(WeekCellView.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self

        addSubview(collectionView)
        collectionView.pin.all().activate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalendarView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 // Hardcoded Example
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? WeekCellView
        cell?.viewModel = WeekCellViewModel(date: Date())
        return cell ?? UICollectionViewCell()
    }
}

extension CalendarView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
}
