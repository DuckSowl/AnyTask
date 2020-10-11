//
//  PomodoroView.swift
//  AnyTask
//
//  Created by Anton Tolstov on 03.10.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class PomodoroView: DismissibleView {
    
    // MARK: - Subviews
    
    private let startButton = Button.with(type: .text("Start"))
    private let timerView = TimerView(.init(timeInterval: .fourty))
    
    private let timePicker = UIPickerView()
    private let vStack = UIStackView()
    
    private let taskInfoView: UIView
    
    // MARK: - Initializers
    
    init(_ taskViewModel: TaskViewModel) {
        taskInfoView = TaskDetailsView(taskViewModel, info: true).info
        super.init()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func configureView() {
        timerView.isHidden = true

        configureBackgroundView()
        configureTimePickerView()
        configureStackView()
        configureStartStopButtons()
    }
    
    private func configureBackgroundView() {
        backgroundColor = Color.shade
        set(cornerRadius: .medium)
        
        contentView.pin(super: self).center().activate
        contentView.backgroundColor = Color.gray
        contentView.set(cornerRadius: .medium)
    }
    
    private func configureTimePickerView() {
        timePicker.delegate = self
        timePicker.dataSource = self
        timePicker.pin.size(.init(width: 360, height: 100)).activate
    }
    
    private func configureStackView() {
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.pin(super: contentView).all(Layout.contentInset).activate
        
        
        [taskInfoView, timePicker, timerView, startButton].forEach {
            vStack.addArrangedSubview($0)
        }
    }
    
    private func configureStartStopButtons() {
        startButton.addTarget(self, action: #selector(toggleTimer),
                              for: .touchUpInside)
        
    }
    
    @objc private func toggleTimer() {
        UIView.animate(withDuration: 0.4) {
            [self.timerView, self.timePicker].forEach { $0.isHidden.toggle() }
        }
        
        let start = !self.timerView.isHidden
        startButton.setTitle(start ? "Stop" : "Start", for: .normal)
        if start {
            let timerViewModel = TimerViewModel(timeInterval: PomodoroTimeIntervals.allCases[ timePicker.selectedRow(inComponent: 0)])
            timerView.viewModel = timerViewModel
            timerViewModel.start()
        }
    }
    
    @objc override func dismiss() {
        if !self.timerView.isHidden {
            let alert = UIAlertController(title: "Dismissing pomodoro",
                                          message: "Are you sure you want to leave?",
                                          preferredStyle: .alert)
            alert.addAction(.init(title: "Stay", style: .default,
                                  handler: nil))
            alert.addAction(.init(title: "Leave", style: .destructive,
                                  handler: { _ in super.dismiss() }))
            rootVC?.present(alert, animated: true)
        } else {
            super.dismiss()
        }
    }
}

extension PomodoroView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return PomodoroTimeIntervals.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(PomodoroTimeIntervals.allCases[row].rawValue) min"
    }
}
