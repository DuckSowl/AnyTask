//
//  ViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 29.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        let weekView = CalendarView(viewModel: CalendarViewModel())
                
        view.addSubview(weekView)
        weekView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weekView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            weekView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weekView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weekView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

