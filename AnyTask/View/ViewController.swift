//
//  ViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 29.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var addTaskViewController: AddTaskViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        let tabBarView = TabBarView()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)
        
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        let taskViewController = TaskTableViewController()
        guard let taskView = taskViewController.view else { return }
        self.addChild(taskViewController)
        view.insertSubview(taskView, at: 0)
        taskViewController.didMove(toParent: self)
        
        taskView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskView.topAnchor.constraint(equalTo: view.topAnchor),
            taskView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor),
            taskView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tabBarView.delegate = self
    }
    
    
}

extension ViewController: TabBarDelegate {
    func didSelect(tab: Tab) {
        view.backgroundColor = UIColor(red: CGFloat.random(in: 0.2...0.8), green: CGFloat.random(in: 0.2...0.8), blue: CGFloat.random(in: 0.2...0.8), alpha: 1)
    }
    
    func didPressAdd() {
        addTaskViewController = AddTaskViewController()
        addTaskViewController.view.frame = view.frame
        self.addChild(addTaskViewController)
        view.addSubview(addTaskViewController.view)
        addTaskViewController.didMove(toParent: self)
    }
}
