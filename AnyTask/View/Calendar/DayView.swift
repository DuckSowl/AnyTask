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
    
    private func createLabel(text: String, ofSize size: CGFloat) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: size)
        label.text = text
        return label
    }
    
    private func setupView() {
        backgroundColor = viewModel.backgroundColor
        layer.cornerRadius = viewModel.cornerRadius
        
        let weekSymbolLabel = createLabel(text: viewModel.weekSymbol,
                                          ofSize: viewModel.weekSymbolFontSize)
        
        let dayLabel = createLabel(text: viewModel.dateString,
                                   ofSize: viewModel.dateStringFontSize)
        dayLabel.adjustsFontSizeToFitWidth = true
        
        let stack = UIStackView(arrangedSubviews: [weekSymbolLabel, dayLabel])
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        
        addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: viewModel.widthAnchorConstant),
            stack.topAnchor.constraint(equalTo: topAnchor,
                                       constant: viewModel.anhcorConstants.top),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: viewModel.anhcorConstants.left),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor,
                                            constant: viewModel.anhcorConstants.right),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor,
                                          constant: viewModel.anhcorConstants.bottom)
        ])
    }
}