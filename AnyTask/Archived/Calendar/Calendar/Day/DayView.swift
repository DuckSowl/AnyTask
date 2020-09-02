//
//  DayView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 06.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

final class DayView: UIView {
    
    private let viewModel: DayViewModel

    init(viewModel: DayViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = viewModel.backgroundColor
        set(cornerRadius: .small)
        
        let weekSymbolLabel = UILabel(text: viewModel.weekSymbol, font: Font.body)
        let dayLabel =  UILabel(text: viewModel.dateString, font: Font.body)
        
        dayLabel.adjustsFontSizeToFitWidth = true
        
        let stack = UIStackView(arrangedSubviews: [weekSymbolLabel, dayLabel])
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        
        addSubview(stack)
    
        self.pin.width(viewModel.widthAnchorConstant).activate
        stack.pin.all(insets: viewModel.stackInsets).activate
    }
}
