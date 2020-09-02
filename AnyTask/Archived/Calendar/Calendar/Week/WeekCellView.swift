//
//  WeekCellView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

final class WeekCellView: UICollectionViewCell {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        stackView.pin.topBottom().sides(viewModel.sideAnchor).activate
        
        return stackView
    }()
    
    var viewModel: WeekCellViewModel! {
        didSet {
            stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }
            
            viewModel.dayViewModels
                .map { DayView(viewModel: $0) }
                .forEach { stackView.addArrangedSubview($0) }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
