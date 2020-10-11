//
//  TimerView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 10.10.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

enum PomodoroTimeIntervals: Int, CaseIterable {
    case ten = 10
    case twenty = 20
    case thirty = 30
    case fourty = 40
    case fifty = 50
    case sixty = 60
    case eighty = 80
    case hundred = 100
    case hundredTwenty = 120
}

class TimerViewModel {
    
    // MARK: - View Model
    
    var timeInterval: PomodoroTimeIntervals {
        didSet {
            stop()
            reset()
        }
    }
    
    var hour: Int { time / (60 * 60) }
    var minute: Int { (time / 60) % 60 }
    var second: Int { time % 60 }
    
    // MARK: - Properties
    
    var delegate: UpdateDelegate?
    
    // MARK: - Private Properties
    
    private var time = 120 * 60
    private var timer: Timer?

    // MARK: - Initializers
    
    init(timeInterval: PomodoroTimeIntervals) {
        self.timeInterval = timeInterval
        reset()
    }
    
    // MARK: - Methods
    
    func start() {
        timer = .scheduledTimer(timeInterval: 1, target: self,
                                selector: #selector(update),
                                userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    // MARK: - Private Methods
    
    @objc private func update() {
        time -= 1
        if time == 0 { stop() }
        delegate?.update()
    }
   
    private func reset() {
        time = timeInterval.rawValue * 60
        delegate?.update()
    }
}

class TimerView: UIView {
        
    // MARK: - Properties
    
    var viewModel: TimerViewModel {
        didSet {
            updateFromViewModel()
            viewModel.delegate = self
        }
    }
    
    private func updateFromViewModel() {
        hourLabel.text = String(format: "%02dh", viewModel.hour)
        minuteLabel.text = String(format: "%02dm", viewModel.minute)
        secondLabel.text = String(format: "%02ds", viewModel.second)
    }
    
    // MARK: - Subviews
    
    private let hourLabel = UILabel(font: Font.large)
    private let minuteLabel = UILabel(font: Font.large)
    private let secondLabel = UILabel(font: Font.large)
    
    // MARK: - Initializers
    
    init(_ viewModel: TimerViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        viewModel.delegate = self
        configureView()
        updateFromViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        set(cornerRadius: .medium)
        backgroundColor = Color.dark
        let timeLabels = [hourLabel, minuteLabel, secondLabel]
        timeLabels.forEach { $0.textColor = Color.light }
        let stack = UIStackView(arrangedSubviews: timeLabels)
        stack.distribution = .equalCentering
        stack.spacing = 8
        stack.pin(super: self).all(Layout.contentInset).activate
    }
}

extension TimerView: UpdateDelegate {
    func update() {
        updateFromViewModel()
    }
}
